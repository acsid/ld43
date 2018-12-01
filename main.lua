--Ludumdare 43 Entry

--load Required library
Gamestate = require 'libs.hump.gamestate'
Timer = require 'libs.hump.timer'

local gameWorld = require 'gamestates.gameWorld'
local pause = require 'gamestates.Pause' 


gameName = "Kamikaze and Human Shield!";

function love.load()
	love.window.setTitle(("Ludum Dare - %s "):format(gameName))
	Gamestate.registerEvents()
	Gamestate.switch(gameWorld)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")	
	end
end