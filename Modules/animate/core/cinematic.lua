Timeline = require('animate.core.timeline')

-- for now only 1 timeline is managed

local Cinematic = {
	title = '',
	timeline = nil,
}

Cinematic.play = function(self)
	self.timeline:play()
end

Cinematic.stop = function(self)
	self.timeline:stop()
end

Cinematic.pause = function(self)
	self.timeline:pause()
end

Cinematic.create = function(self) end

Cinematic.new = function(self, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.timeline = Timeline:new()
	o:create()
	return o
end

return Cinematic