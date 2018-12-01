--Ludumdare 43 Entry

--load Required library
Gamestate = require 'libs.hump.gamestate'
Timer = require 'libs.hump.timer'


gameName = "Sacrifice must Be MADE!";

function love.load()
	love.window.setTitle(("Ludum Dare 43 - %s "):format(gameName))
	Gamestate.registerEvents()
	Gamestate.switch(gameWorld)
end