
Animate = {
	cinematics = {},
	cinematic = nil,
}

Animate.Cinematic = require('animate.core.cinematic')
Animate.Keyframe = require('animate.core.keyframe')
Animate.Camera = require('animate.core.actors.camera')
Animate.Input = require('animate.core.input')

Animate.init = function(self)
	self:loadCinematics()
	self:set('Goblinwatch 01')
	self.Input:init()
end

Animate.loadCinematics = function(self)
	local cinematics = {}
	for s in path.find(AppPath .. "scripts/modules/animate/cinematics/*.lua") do
		local filename = path.name(s)
		filename = filename:sub(0, #filename - 4)
		s = 'animate.cinematics.'  .. filename
		local newCinematic = require(s)
		newCinematic.filename = filename
		newCinematic = self.Cinematic:new(newCinematic)
		cinematics[newCinematic.title] = newCinematic
	end
	self.cinematics = cinematics
end

Animate.play = function(self, title)
	if (self.cinematic and self.cinematic.timeline.isPlaying == false) then
		self.cinematic:play()
		Game.ShowStatusText('Play')
	end
end

Animate.stop = function(self)
	if (self.cinematic and self.cinematic.timeline.isPlaying == true) then
		self.cinematic:stop()
		Game.ShowStatusText('Stop')
	end
end

Animate.pause = function(self)
	if (self.cinematic and self.cinematic.timeline.isPlaying == true) then
		self.cinematic:pause()
		Game.ShowStatusText('Pause')
	end
end

Animate.set = function(self, title)
	local newCinematic = self.cinematics[title]
	if (newCinematic) then
		self:stop()
		self.cinematic = newCinematic
	end
end

return Animate