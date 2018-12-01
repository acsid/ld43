--require libs
local sti = require 'libs.sti'
local bump = require 'libs.bump'
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'
local Camera = require 'libs.hump.camera'

local LevelBase = Class{
	__includes = Gamestate,
	init = function(self,mapFile)
	self.map = sti(mapFile, {'bump'})
	self.world = bump.newWorld(16)
	self.map:bump_init(self.world)
	camera = Camera(0,0,1) --x,y,scale
	Entities:enter()
	end;
	Entities = Entities;
}

function LevelBase:keypressed(key)
	if Gamestate.current() ~= pause  and key == 'p' then
		Gamestate.push(pause)
	end
end



return LevelBase