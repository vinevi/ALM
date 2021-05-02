local Camera = {
	IndoorFOV = 65,
	OutdoorFOV = 170,
	Yaw = 0,
	Pitch = 0,
	X = 0,
	Y = 0,
	Z = 0,
	isAttached = true,
	lastProperties = {
		X = 0,
		Y = 0,
		Z = 0,
		IndoorFOV = 65,
		OutdoorFOV = 170,
		Yaw = 0,
		Pitch = 0,
	},
}

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
	mem.i4['0x004d5168'] = value
end

-- Pitch

Camera.getPitch = function(self)
	return self.Pitch
end

Camera.setPitch = function(self, value)
	self.Pitch = value
	mem.i4['0x004d5164'] = value
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
	mem.i4['0x004d5158'] = value + 160
end

Camera.reset = function(self)
	self:attach()
end

Camera.detach = function(self)
	if (self.isAttached == true) then
		mem.u4[0x00908c84] = 0 --forward offset
		-- x
		mem.nop(0x00435207)
		mem.asmpatch(0x0046a04e, 'MOV ECX,dword ptr [0x004d5150]')
		mem.asmpatch(0x0046a0e4, 'MOV EDX,dword ptr [0x004d5150]')
		-- y
		mem.nop(0x00435219)
		mem.asmpatch(0x0046a0aa, 'MOV EDX,dword ptr [0x004d5154]')
		mem.asmpatch(0x0046a0fa, 'MOV EAX,[0x004d5154]')
		-- z
		mem.nop(0x0043523a)
		mem.asmpatch(0x0046a0b0, 'MOV ECX,dword ptr [0x004d5158]')
		mem.u4[0x00908c7c] = 0 -- eye level
		-- angles
		mem.nop(0x00435240) -- horizontal angle
		mem.nop(0x00435246) -- vertical angle

		mem.nop(0x00469fff) -- horizontal angle
		mem.nop(0x0046a009) -- vertical angle

		self.isAttached = false
	end
end

Camera.attach = function(self)
	if (self.isAttached == false) then
		mem.u4[0x00908c84] = 25 --forward offset

		-- x
		mem.asmpatch(0x00435207, 'MOV dword ptr [0x00908cac],EDX')
		mem.asmpatch(0x0046a04e, 'MOV ECX,dword ptr [0x00908c98]')
		mem.asmpatch(0x0046a0e4, 'MOV EDX,dword ptr [0x00908c98]')
		-- y
		mem.asmpatch(0x00435219, 'MOV dword ptr [0x00908cb0],EDX')
		mem.asmpatch(0x0046a0aa, 'MOV EDX,dword ptr [0x00908c9c]')
		mem.asmpatch(0x0046a0fa, 'MOV EAX,[0x00908c9c]')
		-- z
		mem.asmpatch(0x0043523a, 'MOV dword ptr [0x00908cb4],EBP')
		mem.asmpatch(0x0046a0b0, 'MOV ECX,dword ptr [0x00908ca0]')
		mem.u4[0x00908c7c] = 160 -- eye level
		-- angles
		mem.asmpatch(0x00435240, 'MOV dword ptr [0x00908cb8],EDI')
		mem.asmpatch(0x00435246, 'MOV dword ptr [0x00908cbc],ESI')

		mem.asmpatch(0x00469fff, 'MOV [0x004d5164],EAX')
		mem.asmpatch(0x0046a009, 'MOV dword ptr [0x004d5168],ECX')

		self.isAttached = true
	end
end

return Camera