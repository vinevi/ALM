local Actor = require('alm.core.actor')

local Model = Actor:new()
Model.X = 0
Model.Y = 0
Model.Z = 0
Model.Yaw = 0
Model.modelIndex = 0
Model.model = nil

-- X

Model.getX = function(self)
	return self.X
end

Model.setX = function(self, value)
	local model = Game.Map.Models[self.modelIndex]
	local difference = self.X - value
	self.X = value
	MoveModel(self.model, difference, 0, 0)
	Game.ShowStatusText(self.X .. ' ' .. self.Y .. ' ' .. self.Z)
end

-- Y

Model.getY = function(self)
	return self.Y
end

Model.setY = function(self, value)
	local model = Game.Map.Models[self.modelIndex]
	local difference = self.Y - value
	self.Y = value
	MoveModel(self.model, 0, difference, 0)
end

-- Z

Model.getZ = function(self)
	return self.Z
end

Model.setZ = function(self, value)
	local difference = self.Z - value
	self.Z = value
	MoveModel(self.model, 0, 0, difference)
end

Model.detach = function(self)
	self.model = Game.Map.Models[self.modelIndex]
	self.model.almModel = self
end

return Model