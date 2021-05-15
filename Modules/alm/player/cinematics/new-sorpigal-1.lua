return {
	title = 'New Sorpigal 1',
	create = function(self)
		local camera = alm.Camera:new()
		self.t:set(camera, {X = -9814, Y = -6515, Z = 161, Yaw = 1592, Pitch = 0})
		self.t:to(camera, {X = -9814, Y = -6515, Z = 161, Yaw = 1592, Pitch = 0, Duration = 1})
		self.t:to(camera, {X = -9625, Y = -6633, Z = 577, Yaw = 1808, Pitch = 0, Duration = 5})
		self.t:to(camera, {X = -14020, Y = -10172, Z = 883, Yaw = 1048, Pitch = -50, Duration = 8})
		self.t:to(camera, {X = -18829, Y = -10431, Z = 22, Yaw = 1288, Pitch = 0, Duration = 8})
		self.t:to(camera, {X = -18829, Y = -10431, Z = 22, Yaw = 812, Pitch = 0, Duration = 3})
		self.t:to(camera, {X = -18253, Y = -4038, Z = 501, Yaw = 480, Pitch = 0, Duration = 8})
		self.t:to(camera, {X = -20618, Y = -1245, Z = 160, Yaw = 968, Pitch = 0, Duration = 5})
	end
}