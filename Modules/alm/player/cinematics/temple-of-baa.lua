return {
	title = 'Temple of Baa',
	create = function(self)
		local camera = alm.Camera:new()
		self.t:set(camera, {X = -15592, Y = 120, Z = -191, Yaw = 0, Pitch = 0})
		self.t:to(camera, {X = -14592, Y = 120, Z = -280, Yaw = 0, Pitch = -25, Duration = 5})
		self.t:to(camera, {X = -13592, Y = 120, Yaw = 0, Pitch = 0, Duration = 5, onBegin = function() Game.ShowStatusText('keyframe start') end})
	end
}

