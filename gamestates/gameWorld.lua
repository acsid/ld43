--import libraries
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'

local LevelBase = require 'gamestates.LevelBase'


local Theking = require 'entities.theking'
local Kamikaze = require 'entities.kamikaze'

king = nil

ent = nil


local gameWorld = Class{
	__includes = LevelBase
}

function gameWorld:init()
	LevelBase.init(self,'map.lua')
end

function gameWorld:enter()
	--spawn entity from map data 
	gameWorld:spawn()
	
end

function gameWorld:update(dt)
	self.map:update(dt)
  
	LevelBase.Entities:update(dt)
end

function gameWorld:draw()
	--set the camera on 0,0
	camera:lookAt(king.x,king.y)	
	--attach camera and draw map and entities
	camera:attach()

	self.map:draw()

	
	LevelBase.Entities:draw()
 	--self.map:bump_draw(self.world)
	--detach camera
	camera:detach()
end


--spawn objects in the world using map data or entity
function gameWorld:spawn(objects)
	local obj = objects or self.map.objects
 for k, object in pairs(obj) do
		if object.name == "theKing" then
			king = Theking(self.world,object.x,object.y)
	LevelBase.Entities:add(king)
   kamikaze = Kamikaze(self.world,king,object.x,object.y)
   kamikaze.isEnemy = false;
   LevelBase.Entities:add(kamikaze)
   
      kamikaze = Kamikaze(self.world,king,object.x+32,object.y)
      kamikaze.isEnemy = false;
   LevelBase.Entities:add(kamikaze)
  
  end
  if object.name == "kamikaze" then
    kamikaze = Kamikaze(self.world,king,object.x,object.y)
    kamikaze.isEnemy = true;
   LevelBase.Entities:add(kamikaze)
 end
 end
end

return gameWorld