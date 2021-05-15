local Editor = require('alm.core.editor')
local Time = require('alm.core.time')

local Input = {}

local timeline = require('alm.timelines.goblinwatch')
Input.init = function()

	function Keys.F(t)
		if (Game.CurrentScreen == 0) then
			Editor:generateKeyframe()
		end
	end

	function Keys.O(t)
		if (Game.CurrentScreen == 0) then
			timeline:stop()
		end
	end
	
	function Keys.P(t)
		if (Game.CurrentScreen == 0) then
			if (timeline.isPlaying == false) then
				timeline:play()
			else
				timeline:pause()
			end
		end
	end

	function Keys.K(t)
		if (Game.CurrentScreen == 0) then
			local time = Time.ticksToSeconds(timeline.time) - 1
			timeline:seek(time)
		end
	end

	function Keys.L(t)
		if (Game.CurrentScreen == 0) then
			local time = Time.ticksToSeconds(timeline.time) + 1
			timeline:seek(time)
		end
	end

	function Keys.J(t)
		if (Game.CurrentScreen == 0) then
			if (timeline.direction == 'forward') then
				timeline:setDirection('reverse')
			else
				timeline:setDirection('forward')
			end
		end
	end

	function Keys.H(t)
		if (Game.CurrentScreen == 0) then
			-- Keyframe standalone example
			alm.Camera:resetProperties()
			local testAnimation = alm.Keyframe:new()
			testAnimation:to(alm.Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, duration = 15.2})
			testAnimation:play()
		end
	end
end

return Input