local Keyframe = {
	object = {}, -- object with properties
	duration = 25, -- in ticks
	increment = 4,
	timer = nil,
	timeline = nil,
	progress = 0,
	start = 0,
	finish = 0,
}

Keyframe.to = function(self, object, properties, duration)
	self.object = object
	self.propertiesTo = {}
	self.propertiesFrom = {}
	for key, value in pairs(properties) do
		self.propertiesTo[key] = value
		self.propertiesFrom[key] = self.object.lastProperties[key]
	end
	self.duration = duration
end

Keyframe.seek = function(self, tick)
	self.progress = ((tick - self.start) / self.duration) -- progress normalized

	for key, targetValue in pairs(self.propertiesTo) do
		if(self.object[key]) then
			local initialValue = self.propertiesFrom[key] or 0
			local newValue = (1 - self.progress) * initialValue + self.progress * targetValue
			self.object['set' .. key](self.object, newValue)
		end
	end
end

function Keyframe:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

return Keyframe