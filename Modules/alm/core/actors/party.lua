local Actor = require('alm.core.actor')

local Party = Actor:new() 

Party.Yaw = 0
Party.YawWrap = 2047
Party.Pitch = 0
Party.X = 0
Party.Y = 0
Party.Z = 0

-- Pitch

Party.getPitch = function(self)
	return self.Pitch
end

Party.setPitch = function(self, value)
	self.Pitch = value
	mem.i4['0x00908ca8'] = value
end

-- Yaw

Party.getYaw = function(self)
	return self.Yaw
end

Party.setYaw = function(self, value)
	self.Yaw = value
	mem.i4['0x00908ca4'] = value
end

-- X

Party.getX = function(self)
	return self.X
end

Party.setX = function(self, value)
	self.X = value
	mem.i4['0x00908c98'] = value
end

-- Y

Party.getY = function(self)
	return self.Y
end

Party.setY = function(self, value)
	self.Y = value
	mem.i4['0x00908c9c'] = value
end

-- Z

Party.getZ = function(self)
	return self.Z
end

Party.setZ = function(self, value)
	self.Z = value
	mem.i4['0x00908ca0'] = value + 160
end

Party.reset = function(self)
	self:attach()
end

Party.detach = function(self)
	if (self.isAttached == true) then
			mem.nop(0x0045c569) -- outdoor
			mem.nop(0x0045c535) -- indoor
		self.isAttached = false
	end
end

Party.attach = function(self)
	if (self.isAttached == false) then
			mem.asmpatch(0x0045c569, 'CALL absolute 0x00464e40')
			mem.asmpatch(0x0045c535, 'CALL absolute 0x00463a20')
		self.isAttached = true
	end
end

return Party