alm = {}

alm.Keyframe = require('alm.core.keyframe')
alm.Timeline = require('alm.core.timeline')
alm.Input = require('alm.core.input')

alm.Player = require('alm.player.main')

alm.Camera = require('alm.core.actors.camera')
alm.Model = require('alm.core.actors.model')

alm.to = function(object, properties)
	local timeline = alm.Timeline:new()
	timeline:to(object, properties)
	timeline:play()
end

alm.init = function(self)
	self.Player:init()
	self.Input:init()
end

return alm