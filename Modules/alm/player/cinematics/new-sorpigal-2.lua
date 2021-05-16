return {
	title = 'New Sorpigal 2',
	create = function(self)
		local model = alm.Model:new({X = -20088, Y = -10376, Z = 0, modelIndex = 20}) -- bridge to Castle Ironfist
		self.t:to(model, {X = -19000, Y = -9000, Duration = 10})
	end
}