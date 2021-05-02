local Time = {}

Time.secondsToTicks = function(seconds)
	return math.floor(seconds * 25)
end

Time.ticksToSeconds = function(ticks)
	return math.floor(ticks / 25)
end

return Time