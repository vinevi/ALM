local Editor = require('animate.core.editor')
local Input = {}

Input.init = function()

	function Keys.F(t)
		Editor:generateKeyframe()
	end

	function Keys.O(t)
		Animate:stop()
	end
	
	function Keys.P(t)
		if (Animate.cinematic.timeline.isPlaying == false) then
			Animate:play()
		else
			Animate:pause()
		end
	end

	function Keys.K(t)
		Animate:seek()
	end

	function Keys.G(t)
		-- Timeline standalone example

		Animate.Camera:resetProperties()
		testTimeline = Animate.Timeline:new()
		testTimeline:to(Animate.Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, duration = 15.2})
		testTimeline:play()
	end

	function Keys.H(t)
		-- Keyframe standalone example

		Animate.Camera:resetProperties()
		testAnimation = Animate.Keyframe:new()
		testAnimation:to(Animate.Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, duration = 15.2})
		testAnimation:play()
	end
end

return Input