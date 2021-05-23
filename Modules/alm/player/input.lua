-- Key bindings used to control the player

local PlayerInput = {}

PlayerInput.init = function(self)
	local playerInputEvents = {
		[const.Keys.O] = function()
			alm.Player:stop()
		end,
		[const.Keys.P] = function()
			alm.Player:play('Temple of Baa')
		end,
		[const.Keys.K] = function()
			alm.Player:rewind()
		end,
		[const.Keys.L] = function()
			alm.Player:fastForward()
		end,
		[const.Keys.J] = function()
			alm.Player:toggleDirection()
		end,
		[const.Keys.D] = function()
			alm.Player:stop()
			alm.Player:reload()
		end,
		
	}

	function events.KeyDown(t)
		local isInGame = Game.CurrentScreen == 0 and Game.MainMenuCode == -1
		local keyFunction = playerInputEvents[t.Key]
		if(keyFunction and isInGame == true) then
			keyFunction()
		end
	end
end

return PlayerInput