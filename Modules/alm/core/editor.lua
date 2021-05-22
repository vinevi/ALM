local Editor = {}

map = function(target)
	evt.MoveToMap(0,0,0,512,0,0,0,0,target)
end

Editor.generateKeyframe = function(self)
	debug.Message('self.t:to(camera, {X = ' .. Party.X .. ', Y = ' .. Party.Y .. ', Z = ' .. Party.Z .. ', Yaw = ' .. Party.Direction .. ', Pitch = ' .. Party.LookAngle .. '})' )
end

return Editor