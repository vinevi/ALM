-- One animation per keyframe
-- Can be controlled by timelines or instanced solely
-- Require from and to values

local Time = require('alm.core.time')
local Interpolation = require('alm.core.interpolation')

local Keyframe = {
	object = {}, -- object with properties
	Duration = 1, -- in seconds (converted to ticks later)
	Delay = 0,
	Interpolation = 'linear',
	progress = 0,
	time = 0,
	start = 0,
	finish = 0,
	onBegin = function() end,
	onEnd = function() end,
}

Keyframe.to = function(self, object, properties)
	self.object = object
	self.propertiesTo = {}
	self.propertiesFrom = {}
	for key, value in pairs(properties) do
		self.propertiesTo[key] = value
		self.propertiesFrom[key] = self.object.lastProperties[key] or self.object[key]
		if(self.object[key .. 'Wrap']) then
			self:adjustWrap(key, value)
		end
	end
	self.Delay = Time.secondsToTicks(properties.Delay or 0)
	self.Duration = Time.secondsToTicks(properties.Duration)
	if (self.Duration == 0) then
		self.Duration = 1
	end
	self.Interpolation= properties.Interpolation or 'linear'
	self.onBegin = properties.onBegin or function() end
	self.onEnd = properties.onEnd or function() end
end

Keyframe.adjustWrap = function(self, key, value)
	local wrapValue = self.object[key .. 'Wrap']
	local valueFrom = self.propertiesFrom[key]
	local difference = math.abs(valueFrom - value)
	local alt = math.abs(wrapValue - difference)
	if (difference > alt) then
		if (value > valueFrom) then
			alt = valueFrom - alt
		else
			alt = valueFrom + alt
		end
		self.propertiesTo[key] = alt
	end
end

Keyframe.seek = function(self, tick)
	self.object:detach()
	self.progress = ((tick - self.start) / self.Duration) -- progress normalized
	if (self.progress == 0) then
		self:onBegin()
	elseif (self.progress == 1) then
		self:onEnd()
	end
	for key, targetValue in pairs(self.propertiesTo) do
		if(self.object[key]) then
			self:adjustProperty(key, targetValue)
		end
	end
end

Keyframe.adjustProperty = function(self, key, targetValue)
	local initialValue = self.propertiesFrom[key]
	local newValue = Interpolation[self.Interpolation](initialValue, targetValue, self.progress)
	newValue = math.floor(newValue)
	
	-- if needs wrapping (like direction property)
	if(self.object[key .. 'Wrap']) then
		newValue = newValue % self.object[key .. 'Wrap']
	end

	-- if has a setter
	if(self.object['set' .. key]) then
		self.object['set' .. key](self.object, newValue)
	else
		self.object[key] = newValue
	end
end

Keyframe.onTick = function(self)
	self.time = self.time + 1
	self:seek(self.time)
	if(self.time >= self.Duration) then
		self:stop()
	end
end

Keyframe.play = function(self)
	self.onTimer = function()
		self:onTick()
	end
	self.timer = Timer(self.onTimer, const.Second)
end

Keyframe.pause = function(self)
	RemoveTimer(self.onTimer)
end

Keyframe.stop = function(self)
	RemoveTimer(self.onTimer)
	self.time = 0
	self.object:attach()
end

Keyframe.new = function (self, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

return Keyframe