-- Indoor test of camera features

return {
	title = 'Test Indoor',
	onBegin = function(self)
		evt.
	end,
	create = function(self)
		local camera = alm.Camera:new()
		self.t:set(camera, {
			X = 532,
			Y = 6330,
			Z = 1,
			Yaw = 1536,
			Pitch = 0,
			IndoorFOV = 60,
		})
		self.t:to(camera, {
			X = 580,
			Duration = 3,
			onBegin = function()
				Game.ShowStatusText('Testing: X')
			end,
		})
		self.t:to(camera, {
			X = 532,
			Duration = 3,
		})
		self.t:to(camera, {
			Y = 6430,
			Duration = 3,
			onBegin = function()
				Game.ShowStatusText('Testing: Y')
			end,
		})
		self.t:to(camera, {
			Y = 6330,
			Duration = 3,
		})
		self.t:to(camera, {
			Z = 50,
			Duration = 3,
			onBegin = function()
				Game.ShowStatusText('Testing: Z')
			end,
		})
		self.t:to(camera, {
			Z = 1,
			Duration = 3,
		})
		self.t:to(camera, {
			Yaw = 0,
			Duration = 3,
			onBegin = function()
				Game.ShowStatusText('Testing: Yaw')
			end,
		})
		self.t:to(camera, {
			Yaw = 512,
			Duration = 3
		})
		self.t:to(camera, {
			Yaw = 1536,
			Duration = 3
		})
		self.t:to(camera, {
			Pitch = 128,
			Duration = 3,
			onBegin = function()
				Game.ShowStatusText('Testing: Pitch')
			end,
		})
		self.t:to(camera, {
			Pitch = 0,
			Duration = 3
		})
		self.t:to(camera, {
			IndoorFOV = 30,
			Duration = 3,
			onBegin = function()
				Game.ShowStatusText('Testing: FOV')
			end,
		})
		self.t:to(camera, {
			IndoorFOV = 60,
			Duration = 3,
		})
	end
}