local Actor = require('alm.core.actor')

local Camera = Actor:new() 

Camera.IndoorFOV = 65
Camera.OutdoorFOV = 170
Camera.Yaw = 0
Camera.YawWrap = 2047
Camera.Pitch = 0
Camera.X = 0
Camera.Y = 0
Camera.Z = 0

Camera.sync = function(self)

	self.lastProperties = {}

	self.X = mem.i4['0x004d5150']
	self.Y = mem.i4['0x004d5154']
	self.Z = mem.i4['0x004d5158']

	self.IndoorFOV = 65
	self.OutdoorFOV = 170
	self.Yaw = mem.i4['0x004d5168']
	self.Pitch = mem.i4['0x004d5164']

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

-- Pitch

Camera.getPitch = function(self)
	return self.Pitch
end

Camera.setPitch = function(self, value)
	self.Pitch = value
	mem.i4['0x004d5164'] = value
end

-- Yaw

Camera.getYaw = function(self)
	return self.Yaw
end

Camera.setYaw = function(self, value)
	self.Yaw = value
	mem.i4['0x004d5168'] = value
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

		-- common
		mem.nop(0x00435207) -- x
		mem.nop(0x00435219) -- y
		mem.nop(0x0043523a) -- z

		mem.u4[0x00908c7c] = 0 -- eye level

		mem.nop(0x00435240) -- horizontal angle
		mem.nop(0x00435246) -- vertical angle

		-- outdoor
		-- x
		mem.asmpatch(0x0046a04e, 'MOV ECX,dword ptr [0x004d5150]')
		mem.asmpatch(0x0046a0e4, 'MOV EDX,dword ptr [0x004d5150]')
		-- y
		mem.asmpatch(0x0046a0aa, 'MOV EDX,dword ptr [0x004d5154]')
		mem.asmpatch(0x0046a0fa, 'MOV EAX,[0x004d5154]')
		-- z
		mem.asmpatch(0x0046a0b0, 'MOV ECX,dword ptr [0x004d5158]')

		mem.nop(0x00469fff) -- horizontal angle
		mem.nop(0x0046a009) -- vertical angle

		-- indoor
		mem.asmpatch(0x004370b9, 'MOV ECX,dword ptr [0x004d5150]') -- x
		mem.asmpatch(0x00437114, 'MOV EDX,dword ptr [0x004d5154]') -- y
		mem.asmpatch(0x00437122, 'MOV EAX,[0x004d5158]') -- z

		mem.asmpatch(0x00437133, 'MOV EAX,[0x004d5164]') -- vertical angle

		-- horizontal angle
		mem.asmpatch(0x0043712b, 'MOV EDX,dword ptr [0x004d5168]')
		mem.asmpatch(0x004370c7, 'MOV EAX,[0x004d5168]')
		mem.asmpatch(0x00437067, 'MOV ESI,dword ptr [0x004d5168]')

		self.isAttached = false
	end
end

Camera.attach = function(self)
	if (self.isAttached == false) then
		mem.u4[0x00908c84] = 25 --forward offset

		-- common
		
		mem.asmpatch(0x00435207, 'MOV dword ptr [0x00908cac],EDX') -- x
		mem.asmpatch(0x00435219, 'MOV dword ptr [0x00908cb0],EDX') -- y
		mem.asmpatch(0x0043523a, 'MOV dword ptr [0x00908cb4],EBP') -- z

		mem.asmpatch(0x00435240, 'MOV dword ptr [0x00908cb8],EDI') -- horizontal angle
		mem.asmpatch(0x00435246, 'MOV dword ptr [0x00908cbc],ESI') -- vertical angle

		-- outdoor

		-- x
		mem.asmpatch(0x0046a04e, 'MOV ECX,dword ptr [0x00908c98]')
		mem.asmpatch(0x0046a0e4, 'MOV EDX,dword ptr [0x00908c98]')
		-- y
		mem.asmpatch(0x0046a0aa, 'MOV EDX,dword ptr [0x00908c9c]')
		mem.asmpatch(0x0046a0fa, 'MOV EAX,[0x00908c9c]')
		-- z
		mem.asmpatch(0x0046a0b0, 'MOV ECX,dword ptr [0x00908ca0]')
		mem.u4[0x00908c7c] = 160 -- eye level

		-- angles

		mem.asmpatch(0x00469fff, 'MOV [0x004d5164],EAX')
		mem.asmpatch(0x0046a009, 'MOV dword ptr [0x004d5168],ECX')

		-- indoor

		mem.asmpatch(0x004370b9, 'MOV ECX,dword ptr [0x00908c98]') -- x
		mem.asmpatch(0x00437114, 'MOV EDX,dword ptr [0x00908c9c]') -- y
		mem.asmpatch(0x00437122, 'MOV EAX,[0x00908ca0]') -- z

		mem.asmpatch(0x00437133, 'MOV EAX,[0x00908ca8]') -- vertical angle

		-- horizontal angle
		mem.asmpatch(0x0043712b, 'MOV EDX,dword ptr [0x00908ca4]')
		mem.asmpatch(0x004370c7, 'MOV EAX,[0x00908ca4]')
		mem.asmpatch(0x00437067, 'MOV ESI,dword ptr [0x00908ca4]')

		self.isAttached = true
	end
end

return Camera