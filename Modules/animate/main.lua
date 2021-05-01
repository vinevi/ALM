Camera = require('animate.core.camera')
Timeline = require('animate.core.timeline')

local Animate = {}

Animate.generate_key = function(self)
	debug.Message('timeline:to(Camera, {X = ' .. Party.X .. ', Y = ' .. Party.Y .. ', Z = ' .. Party.Z .. ', Yaw = ' .. Party.Direction .. '})' )
end

Animate.init = function(self)
	timeline = {}

	function Keys.L(t)
		self:generate_key()
	end
	function Keys.O(t)
		timeline:stop()
	end
	function Keys.P(t)
		Camera:detach()
		timeline = Timeline:new()
		-- timeline:set(Camera, {X = -17762, Y = -14377, Z = 1600, Yaw = 1336})
		timeline:to(Camera, {X = -17762, Y = -14377, Z = 1600, Yaw = 1336, duration = 0.1})
		timeline:to(Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, duration = 5.2})
		timeline:to(Camera, {X = -19102, Y = -14943, Z = 2136, Yaw = 1968, Pitch = 64, duration = 12.2})
		timeline:to(Camera, {X = -19078, Y = -15007, Z = 1984, Yaw = 1520, Pitch = -64, duration = 1.2}, 13.2)
		timeline:to(Camera, {X = -18986, Y = -15611, Z = 1985, Yaw = 2047, Pitch = 0, duration = 10.2})
		timeline:to(Camera, {OutdoorFOV = 60, duration = 10.2})
		timeline:to(Camera, {X = -19050, Y = -15406, Z = 1984, Yaw = 2036, duration = 12.2})
		timeline:to(Camera, {OutdoorFOV = 170, duration = 10.2})
		timeline:to(Camera, {X = -18507, Y = -15414, Z = 1984, Yaw = 1928, duration = 10.2})
		timeline:play()
	end
end

function Animate:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	return o
end

return Animate:new()