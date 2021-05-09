Animate = {}

Animate.Keyframe = require('animate.core.keyframe')
Animate.Timeline = require('animate.core.timeline')
Animate.Camera = require('animate.core.actors.camera')
Animate.Input = require('animate.core.input')

Animate.init = function(self)
	
	self.Input:init()
end

return Animate