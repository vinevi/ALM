return {
	title = 'New Sorpigal',
	create = function(self)
		local camera = alm.Camera:new()
		self.t:set(camera, {X = -17762, Y = -14377, Z = 1600, Yaw = 1336})
		self.t:to(camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, Duration = 5.2})
		self.t:to(camera, {X = -19102, Y = -14943, Z = 2136, Yaw = 1968, Pitch = 64, Duration = 12.2})
		self.t:to(camera, {X = -19078, Y = -15007, Z = 1984, Yaw = 1520, Pitch = -64, Duration = 1.2}, 13.2)
		self.t:to(camera, {X = -18986, Y = -15611, Z = 1985, Yaw = 2047, Pitch = 0, Duration = 10.2})
		self.t:to(camera, {OutdoorFOV = 60, Duration = 3})
		self.t:to(camera, {X = -19050, Y = -15406, Z = 1984, Yaw = 2036, Duration = 12.2})
		self.t:to(camera, {OutdoorFOV = 170, Duration = 3})
		self.t:to(camera, {X = -18507, Y = -15414, Z = 1984, Yaw = 1928, Duration = 10.2})
	end
}

