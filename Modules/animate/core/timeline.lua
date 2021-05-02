local Keyframe = require('animate.core.keyframe')
local Time = require('animate.core.time')

local Timeline = {
	time = 0,
	duration = 0,
	timer = nil,
	isPlaying = false,
}

Timeline.updateDuration = function(self)
	self.duration = 0
	for key,keyframe in pairs(self.keyframes) do
		keyframe.start = self.duration
		self.duration = self.duration + keyframe.duration
		keyframe.finish = self.duration
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
	properties.duration = 0
	self:to(object, properties)
end

Timeline.seek = function(self, time)
	self.keyframesActive = {}
	self.time = Time.secondsToTicks(time)
end

-- Standalone functions --

Timeline.updateActiveKeyframes = function(self)
	self.keyframesActive = {}
	for key,keyframe in pairs(self.keyframes) do
		if( keyframe.start <= self.time and keyframe.finish >= self.time ) then
			table.insert(self.keyframesActive, keyframe)
		end
	end
end

Timeline.onTick = function(self)
	self.time = self.time + 1
	self:updateActiveKeyframes()
	for key,keyframe in pairs(self.keyframesActive) do
		keyframe:seek(self.time)
	end
	if(self.time >= self.duration) then
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
	self.isPlaying = false
	for key,keyframe in pairs(self.keyframes) do
		keyframe.object:attach()
	end
	RemoveTimer(self.onTimer)
	self.keyframesActive = {}
	self.time = 0
end

-- Standalone functions end --

Timeline.new = function(self,o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.keyframes = {}
	o.keyframesActive = {}
	return o
end

return Timeline