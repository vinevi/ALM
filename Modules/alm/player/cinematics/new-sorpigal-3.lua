return {
	title = 'New Sorpigal 3',
	create = function(self)
		self.t:set(alm.Party, {X = -9728, Y = -11319, Z = 0, Yaw = 512, Pitch = 0})
		self.t:to(alm.Party, {Y = -11000, Duration = 1})
		self.t:to(alm.Party, {Y = -11319, Duration = 1})
		self.t:to(alm.Party, {X = -9428, Duration = 1})
		self.t:to(alm.Party, {X = -9728, Duration = 1})
		self.t:to(alm.Party, {Y = -11619, Duration = 1})
		self.t:to(alm.Party, {Y = -11319, Duration = 1})
		self.t:to(alm.Party, {X = -10028, Duration = 1})
		self.t:to(alm.Party, {X = -9728, Duration = 1})
		self.t:to(alm.Party, {Yaw = 0, Duration = 1})
		self.t:to(alm.Party, {Yaw = 512, Duration = 1})
		self.t:to(alm.Party, {Yaw = 1024, Duration = 1})
		self.t:to(alm.Party, {Yaw = 512, Duration = 1})
		self.t:to(alm.Party, {Pitch = 256, Duration = 1})
		self.t:to(alm.Party, {Pitch = 0, Duration = 1})
		self.t:to(alm.Party, {Pitch = -512, Duration = 1})
		self.t:to(alm.Party, {Pitch = 0, Duration = 1})
	end
}