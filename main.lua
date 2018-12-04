--Ludumdare 43 Entry

--load Required library
Gamestate = require 'libs.hump.gamestate'
Timer = require 'libs.hump.timer'

local gameWorld = require 'gamestates.gameWorld'
local pause = require 'gamestates.Pause' 
local credit = require 'gamestates.Credit'
local splash = require 'gamestates.splash'


gameName = "43 Kamikaze and Human Shield!";
splashsw = true


function distance( x1, y1, x2, y2)
  local dx = x1 - x2
  local dy = y1 - y2 
  return math.sqrt(dx *dx + dy * dy)
end

function love.load()
	love.window.setTitle(("Ludum Dare %s "):format(gameName))
	Gamestate.registerEvents()
	Gamestate.switch(splash)
end

function gameover()
   Gamestate.switch(credit)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")	
	end
  if splashsw == true then
    splashsw = false
  	Gamestate.switch(gameWorld)
  end

end