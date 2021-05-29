Interpolation = {}

Interpolation.linear = function(y1, y2, mu)
	return (1 - mu) * y1 + mu * y2 -- linear interpolation
end

Interpolation.cosine = function(y1, y2, mu)
	local mu2
	mu2 = (1 - math.cos(mu * math.pi)) / 2;
	return(y1 * (1 - mu2) + y2 * mu2);
end

return Interpolation