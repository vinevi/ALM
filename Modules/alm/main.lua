alm = {}

alm.Keyframe = require('alm.core.keyframe')
alm.Timeline = require('alm.core.timeline')
alm.Camera = require('alm.core.actors.camera')
alm.Input = require('alm.core.input')
alm.Player = require('alm.player.main')

alm.init = function(self)
	self.Player:init()
	self.Input:init()
end

return alm