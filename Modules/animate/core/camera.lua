local Camera = {
	IndoorFOV = 65,
	OutdoorFOV = 170,
	Yaw = 0,
	Pitch = 0,
	X = -9728,
	Y = -11319,
}

function Camera:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- Indoor FOV

Camera.getIndoorFOV = function(self)
	return self.IndoorFOV
end

Camera.setIndoorFOV = function(self, value)
	self.OutdoorFOV = value
	mem.asmpatch(0x00437191, 'MOV dword ptr [ESP + 0x1c],' .. value)
end

-- Outdoor FOV

Camera.getOutdoorFOV = function(self)
	return self.OutdoorFOV
end

Camera.setOutdoorFOV = function(self, value)
	self.OutdoorFOV = value
	mem.asmpatch(0x004789f5, 'AND EAX, ' .. value);
	mem.call(0x004582cd)
end

-- Yaw

Camera.getYaw = function(self)
	return self.Yaw
end

Camera.setYaw = function(self, value)
	self.Yaw = value
	mem.u4['0x004d5168'] = value
end

-- Pitch

Camera.getPitch = function(self)
	return self.Pitch
end

Camera.setPitch = function(self, value)
	self.Pitch = value
	mem.u4['0x004d5164'] = value
end

-- X

Camera.getX = function(self)
	return self.X
end

Camera.setX = function(self, value)
	self.X = value
	mem.i4['0x004d5150'] = value
end

-- Y

Camera.getY = function(self)
	return self.Y
end

Camera.setY = function(self, value)
	self.Y = value
	mem.i4['0x004d5154'] = value
end

-- Z

Camera.getZ = function(self)
	return self.Z
end

Camera.setZ = function(self, value)
	self.Z = value
	mem.i4['0x004d5158'] = value
end

Camera.detach = function(self)
	mem.u4[0x00908c84] = 0
	-- x

	mem.nop(0x00435207)

	mem.asmpatch(0x0046a04e, [[
		MOV ECX,dword ptr [0x004d5150]
	]])
	mem.asmpatch(0x0046a0e4, [[
		MOV EDX,dword ptr [0x004d5150]
	]])

	-- y

	mem.nop(0x00435219)

	mem.asmpatch(0x0046a0aa, [[
		MOV EDX,dword ptr [0x004d5154]
	]])

	mem.asmpatch(0x0046a0fa, [[
		MOV EAX,[0x004d5154]
	]])

	-- z

	mem.nop(0x0043523a)

	-- angles

	mem.nop(0x00435240) -- horizontal angle
	mem.nop(0x00435246) -- vertical angle

	mem.nop(0x00469fff) -- horizontal angle
	mem.nop(0x0046a009) -- vertical angle
end

return Camera