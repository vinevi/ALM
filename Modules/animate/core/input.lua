Editor = require('animate.core.editor')
local Input = {}

Input.init = function()


	function Keys.G(t)
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
end

return Input