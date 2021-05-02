local Editor = require('animate.core.editor')
local Time = require('animate.core.time')

local Input = {}

local timeline = require('animate.timelines.goblinwatch')
Input.init = function()

	function Keys.F(t)
		Editor:generateKeyframe()
	end

	function Keys.O(t)
		timeline:stop()
	end
	
	function Keys.P(t)
		if (timeline.isPlaying == false) then
			timeline:play()
		else
			timeline:pause()
		end
	end

	function Keys.K(t)
		local time = Time.ticksToSeconds(timeline.time) - 1
		timeline:seek(time)
	end

	function Keys.L(t)
		local time = Time.ticksToSeconds(timeline.time) + 1
		timeline:seek(time)
	end

	function Keys.J(t)
		if (timeline.direction == 'forward') then
			timeline:setDirection('reverse')
		else
			timeline:setDirection('forward')
		end
	end

	function Keys.H(t)
		-- Keyframe standalone example

		Animate.Camera:resetProperties()
		local testAnimation = Animate.Keyframe:new()
		testAnimation:to(Animate.Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, duration = 15.2})
		testAnimation:play()
	end
end

return Input