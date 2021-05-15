return {
	title = 'New Sorpigal 2',
	create = function(self)
		local model = alm.Model:new({modelIndex = 20})
		self.t:to(model, {Z = -1000, Duration = 10})
	end
}