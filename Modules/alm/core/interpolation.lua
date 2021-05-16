Interpolation = {}

Interpolation.linear = function(y1, y2, progress)
	return (1 - progress) * y1 + progress * y2 -- linear interpolation
end

Interpolation.cosine = function(y1, y2, progress)
	xv = (1 - math.cos(progress * 3.1415927)) / 2
	return y1 + (y2 - y1) * xv
end

return Interpolation