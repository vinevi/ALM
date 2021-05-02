-- One animation per keyframe
-- Can be controlled by timelines or instanced solely
-- Require from and to values

local Time = require('animate.core.time')

local Keyframe = {
	object = {}, -- object with properties
	duration = 1, -- in seconds (converted to ticks later)
	time = 0,
	start = nil,
	finish = nil,
}

Keyframe.to = function(self, object, properties)
	self.object = object
	self.propertiesTo = {}
	self.propertiesFrom = {}
	for key, value in pairs(properties) do
		self.propertiesTo[key] = value
		self.propertiesFrom[key] = self.object.lastProperties[key]
	end
	
	self.duration = Time.secondsToTicks(properties.duration)
end

Keyframe.seek = function(self, tick)
	self.object:detach()
	self.time = ((tick - self.start) / self.duration) -- progress normalized
	for key, targetValue in pairs(self.propertiesTo) do
		if(self.object[key]) then
			local initialValue = self.propertiesFrom[key] or 0
			local newValue = (1 - self.time) * initialValue + self.time * targetValue
			self.object['set' .. key](self.object, math.floor(newValue))
		end
	end
end

-- Standalone functions --

Keyframe.onTick = function(self)
	self.time = self.time + 1
	self:seek(self.time)
	if(self.time >= self.duration) then
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

-- Standalone function end --


Keyframe.new = function (self, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

return Keyframe