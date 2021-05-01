local Time = {}

Time.secondsToTicks = function(seconds)
	return math.floor(seconds * 25)
end

return Time