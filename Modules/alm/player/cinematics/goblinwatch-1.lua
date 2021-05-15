return {
	title = 'Goblinwatch 1',
	create = function(self)
		local camera = alm.Camera:new()
		self.t:set(camera, {X = 601, Y = 6871, Z = 177, Yaw = 1528, Pitch = 0})
		self.t:to(camera, {X = 782, Y = 6350, Z = 1, Yaw = 1120, Pitch = 25, Duration = 5})
		self.t:to(camera, {X = -282, Y = 6435, Z = 1, Yaw = 1760, Pitch = 0, Duration = 5})
	end
}