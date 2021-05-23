-- This module is made to make playing timelines easier
-- it abstracts it to just alm.Player.play('name') removing the need to require files
-- it also allows to isolate the code for the cinematics into separate files and supports
-- refreshing the code without having to restart the game

local Player = {
	cinematics = {},
	cinematic = nil,
	isPlaying = false,
}

local Time = require('alm.core.time')

Player.Loader = require('alm.player.loader')
Player.Input = require('alm.player.input')

Player.fastForward = function(self)
	local time = Time.ticksToSeconds(self.cinematic.t.time) + 1
	self.cinematic.t:seek(time)
end

Player.rewind = function(self)
	local time = Time.ticksToSeconds(self.cinematic.t.time) - 1
	self.cinematic.t:seek(time)
end

Player.resume = function(self)
	if( self.cinematic) then
		self.cinematic:play()
	end
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
	if (self.cinematic) then
		self.cinematic:stop()
	end
	self.isPlaying = false
end

Player.pause = function(self)
	if (self.cinematic) then
		self.cinematic:pause()
	end
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
	if (self.cinematic.t.isPlaying == false) then
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

Player.reload = function(self)
	self.cinematics = nil
	self.cinematic = nil
	self.Loader = nil
	package.loaded['alm.player.loader'] = nil
	self.Loader = require('alm.player.loader')
	self.cinematics = self.Loader:loadCinematics()
	Game.ShowStatusText('player reloaded')
end

Player.init = function(self)
	self.cinematics = self.Loader:loadCinematics()
	self.Input:init()
end

return Player