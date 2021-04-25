local Key = require('animate.core.key')

local Timeline = {
	keys = {},
	currentKey = 1,
}

function Timeline:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.keys = {}
	return o
end

Timeline.to = function(self, object, properties, increment)
	local newKey = Key:new()
	newKey:to(object, properties, increment, self)
	table.insert(self.keys, newKey)
end

Timeline.play = function(self)
	self.keys[self.currentKey]:play()
	Game.ShowStatusText('key: ' .. self.currentKey)
end

Timeline.stop = function(self)
	for key,timelineKey in pairs(self.keys) do
		RemoveTimer(timelineKey.timer)
	end
end

Timeline.next = function(self)
	self.currentKey = self.currentKey + 1
	if(self.currentKey <= #self.keys) then
		self:play()
	else
		self.currentKey = 1
		self:stop()
	end
end

return Timeline