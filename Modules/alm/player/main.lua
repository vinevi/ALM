local BaseCinematic = require('alm.player.cinematic')
local Time = require('alm.core.time')
local Input = require('alm.player.input')

local Player = {
	cinematics = {},
	cinematic = nil,
	isPlaying = false,
}

Player.fastForward = function(self)
	local time = Time.ticksToSeconds(self.cinematic.t.time) + 1
	self.cinematic.t:seek(time)
end

Player.rewind = function(self)
	local time = Time.ticksToSeconds(self.cinematic.t.time) - 1
	self.cinematic.t:seek(time)
end

Player.resume = function(self)
	self.cinematic:play()
	self.isPlaying = true
end

Player.play = function(self, title)
	if(self.cinematic) then
		if (self.cinematic.title == title) then
			self:togglePause()
		end
		return
	end
	self:set(title)
	self:resume()
end

Player.stop = function(self)
	self.cinematic:stop()
	self.isPlaying = false
end

Player.pause = function(self)
	self.cinematic:pause()
	self.isPlaying = false
end

Player.toggleDirection = function(self)
	if (self.cinematic.t.direction == 'forward') then
		self.cinematic.t:setDirection('reverse')
	else
		self.cinematic.t:setDirection('forward')
	end
end

Player.togglePause = function(self)
	if (self.isPlaying == false) then
		self:resume()
	else
		self:pause()
	end
end

Player.set = function(self, title)
	if (self.cinematic) then
		self.cinematic.t:seek(0)
	end
	local cinematic = self.cinematics[title]
	if (cinematic) then
		self.cinematic = cinematic
	end
end

Player.loadCinematics = function(self)
	for s in path.find(AppPath .. "scripts/modules/alm/player/cinematics/*.lua") do
		local filename = path.name(s)
		filename = filename:sub(0, #filename - 4)
		s = 'alm.player.cinematics.'  .. filename
		local newCinematic = require(s)
		newCinematic.filename = filename
		newCinematic = BaseCinematic:new(newCinematic)
		newCinematic:create()
		self.cinematics[newCinematic.title] = newCinematic
	end
end

Player.init = function(self)
	self:loadCinematics()
	self.Input = Input
	self.Input:init()
end

return Player