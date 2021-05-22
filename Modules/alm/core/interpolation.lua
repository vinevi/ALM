Interpolation = {}

Interpolation.linear = function(y1, y2, progress)
	return (1 - progress) * y1 + progress * y2 -- linear interpolation
end

Interpolation.cosine = function(y1, y2, progress)
	local progress2
	progress2 = (1 - math.cos(progress * math.pi)) / 2;
	return(y1 * (1 - progress2) + y2 * progress2);
end

return Interpolation