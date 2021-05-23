-- This module loads the cinematics from the 'cinematics folder'
-- the code is isolated to make unloading the module easier which makes it
-- possible to refresh the scripts without restarting the game

local Loader = {}
local BaseCinematic = require('alm.player.cinematic')

Loader.loadCinematics = function(self)
	local cinematics = {}
	for s in path.find(AppPath .. "scripts/modules/alm/player/cinematics/*.lua") do
		local filename = path.name(s)
		filename = filename:sub(0, #filename - 4)
		s = 'alm.player.cinematics.'  .. filename
		package.loaded[s] = nil
		local newCinematic = require(s)
		newCinematic.filename = filename
		newCinematic = BaseCinematic:new(newCinematic)
		cinematics[newCinematic.title] = newCinematic
	end
	return cinematics
end

return Loader