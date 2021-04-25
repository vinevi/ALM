Camera = require('animate.core.camera')
Timeline = require('animate.core.timeline')

timeline = {}
Camera.detach()
function Keys.P(t)
	Camera:setX(-9728)
	Camera:setY(-11319)
	Camera:setOutdoorFOV(170)
	timeline = Timeline:new()
	timeline:to(Camera, {X = -9728, Y = -11319, Z = 160, Yaw = 512})
	timeline:to(Camera, {X = -9728, Y = -9423, Z = 160, Yaw = 512})
	timeline:to(Camera, {X = -9455, Y = -9019, Z = 160, Yaw = 168})
	timeline:to(Camera, {X = -9523, Y = -7931, Z = 160, Yaw = 892})
	timeline:play()
end

function Keys.O(t)
	debug.Message('timeline:to(Camera, {X = ' .. Party.X .. ', Y = ' .. Party.Y .. ', Z = ' .. Party.Z .. ', Yaw = ' .. Party.Direction .. '})' )
end