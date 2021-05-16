local Keyframe = require('alm.core.keyframe')
local Time = require('alm.core.time')

local Timeline = {
	time = 0,
	Duration = 0,
	timer = nil,
	isPlaying = false,
	speed = 1,
	direction = 'forward',
}

Timeline.updateDuration = function(self)
	self.Duration = 0
	for key,keyframe in pairs(self.keyframes) do
		keyframe.start = self.Duration + keyframe.Delay
		self.Duration = self.Duration + keyframe.Duration + keyframe.Delay
		keyframe.finish = self.Duration
	end
end

Timeline.to = function(self, object, properties)
	local newKeyframe = Keyframe:new()
	newKeyframe:to(object, properties)
	table.insert(self.keyframes, newKeyframe)
	for key, value in pairs(properties) do
		object.lastProperties[key] = value
	end
	self:updateDuration()
end

Timeline.set = function(self, object, properties)
	properties.Duration = 0
	self:to(object, properties)
end

Timeline.setTime = function(self, time)
	if (time < 0) then
		time = 0
	end
	if (time > self.Duration) then
		time = self.Duration
	end
	self.time = time
end

Timeline.seek = function(self, time)
	self:setTime(Time.secondsToTicks(time))
	self:updateActiveKeyframes()
	for key,keyframe in pairs(self.keyframesActive) do
		keyframe:seek(self.time)
	end
end

Timeline.updateActiveKeyframes = function(self)
	self.keyframesActive = {}
	for key,keyframe in pairs(self.keyframes) do
		if( keyframe.start <= self.time and keyframe.finish >= self.time ) then
			table.insert(self.keyframesActive, keyframe)
		end
	end
end

Timeline.setDirection = function(self, direction)
	if (direction == 'reverse') then
		self.speed = -1
	else
		self.speed = 1
	end
	self.direction = direction
end

Timeline.onTick = function(self)
	self:setTime(self.time + self.speed)
	self:updateActiveKeyframes()
	for key,keyframe in pairs(self.keyframesActive) do
		keyframe:seek(self.time)
	end
	if(self.time >= self.Duration) then
		self:stop()
	end
end

Timeline.play = function(self)
	self.isPlaying = true
	for key,keyframe in pairs(self.keyframes) do
		keyframe.object:detach()
	end
	self.onTimer = function()
		self:onTick()
	end
	self.timer = Timer(self.onTimer, const.Second)
end

Timeline.pause = function(self)
	self.isPlaying = false
	RemoveTimer(self.onTimer)
end

Timeline.stop = function(self)
	if (self.isPlaying == true) then
		self:pause()
		for key,keyframe in pairs(self.keyframes) do
			keyframe.object:attach()
		end
		self.keyframesActive = {}
		self:setTime(0)
	end
end

Timeline.new = function(self,o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.keyframes = {}
	o.keyframesActive = {}
	return o
end

return Timeline