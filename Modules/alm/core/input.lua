local Editor = require('alm.core.editor')

local Input = {}

Input.init = function()
	local inputEvents = {
		[const.Keys.F] = function()
			Editor:generateKeyframe()
		end,
		[const.Keys.H] = function()
			-- Keyframe standalone example
			alm.Camera:resetProperties()
			local keyframe = alm.Keyframe:new()
			keyframe:to(alm.Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, Duration = 15.2})
			keyframe:play()
		end,
		[const.Keys.G] = function()
			-- Timeline standalone example
			local timeline = alm.Timeline:new()
			timeline:set(alm.Camera, {X = -9814, Y = -6515, Z = 161, Yaw = 1592, Pitch = 0})
			timeline:to(alm.Camera, {X = -9814, Y = -6515, Z = 161, Yaw = 1592, Pitch = 0, Duration = 1})
			timeline:to(alm.Camera, {X = -9625, Y = -6633, Z = 577, Yaw = 1808, Pitch = 0, Duration = 5})
			timeline:to(alm.Camera, {X = -14020, Y = -10172, Z = 883, Yaw = 1048, Pitch = -50, Duration = 8})
			timeline:play()
		end,
	}

	function events.KeyDown(t)
		local isInGame = Game.CurrentScreen == 0 and Game.MainMenuCode == -1
		local keyFunction = inputEvents[t.Key]
		if(keyFunction and isInGame == true) then
			keyFunction()
		end
	end
end

return Input