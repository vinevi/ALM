alm = {}

alm.Keyframe = require('alm.core.keyframe')
alm.Timeline = require('alm.core.timeline')
alm.Camera = require('alm.core.actors.camera')
alm.Input = require('alm.core.input')

alm.init = function(self)
	
	self.Input:init()
end

return alm