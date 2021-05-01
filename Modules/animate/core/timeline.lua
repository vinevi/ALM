local Keyframe = require('animate.core.keyframe')
local Time = require('animate.core.time')

function merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

local Timeline = {
	keyframes = {},
	keyframesActive = {},
	time = 0,
	duration = 0,
	timer = nil,
}

function Timeline:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.keys = {}
	return o
end

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
	duration = Time.secondsToTicks(properties.duration)
	newKeyframe:to(object, properties, duration)
	table.insert(self.keyframes, newKeyframe)
	for key, value in pairs(properties) do
		object.lastProperties[key] = value
	end
	self:updateDuration()
	MessageBox(self.keyframes[1].propertiesFrom.X)
end

Timeline.set = function(self, object, properties)
	local newKeyframe = Keyframe:new()
	newKeyframe:to(object, properties, 0, self)
	table.insert(self.keyframes, newKeyframe)
end

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
		--Game.ShowStatusText(keyframe.propertiesFrom.X)
		keyframe:seek(self.time)
	end
	if(self.time >= self.duration) then
		self:stop()
	end
end

Timeline.play = function(self)
	MessageBox(testvalue)
	self.timer = Timer(function()
		self:onTick()
	end, const.Second)
end

Timeline.stop = function(self)
	RemoveTimer(self.timer)
	self.time = 0
end

return Timeline