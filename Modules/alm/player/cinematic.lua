-- Cinematic object prototype

alm.Timeline = require('alm.core.timeline')

return {
	title = 'Cinematic',
	t = nil,
	create = function(self) end,
	play = function(self)
		self.t:play()
	end,
	pause = function(self)
		self.t:pause()
	end,
	stop = function(self)
		self.t:stop()
	end,
	new = function(self, o)
		o = o or {}
		setmetatable(o, self)
		o.t = alm.Timeline:new()
		self.__index = self
		return o
	end,
}