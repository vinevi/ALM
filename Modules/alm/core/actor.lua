local Actor = {}

Actor.new = function(self, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.isAttached = true
	o.lastProperties = {}
	return o
end

Actor.refreshLastProperties = function(self)
	self.lastProperties = {}
end

Actor.attach = function(sef)
	self.isAttached = true
end

Actor.detach = function(self)
	self.isAttached = false
end

return Actor