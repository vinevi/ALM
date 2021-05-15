return {
	title = 'Goblinwatch 1',
	create = function(self)
		self.t:set(alm.Camera, {X = 601, Y = 6871, Z = 177, Yaw = 1528, Pitch = 0})
		self.t:to(alm.Camera, {X = 782, Y = 6350, Z = 1, Yaw = 1120, Pitch = 25, Duration = 5})
		self.t:to(alm.Camera, {X = -282, Y = 6435, Z = 1, Yaw = 1760, Pitch = 0, Duration = 5})
	end
}