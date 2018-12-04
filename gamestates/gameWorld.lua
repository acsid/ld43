--import libraries
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'

local LevelBase = require 'gamestates.LevelBase'
Control = require 'gamestates.Control'
local Ui = require 'gamestates.ui'

local Theking = require 'entities.theking'
local Kamikaze = require 'entities.kamikaze'
local Mechoui = require 'entities.mechoui'
local Pointer = require 'entities.pointer'

king = nil
mechoui = nil

hshield = 4


local gameWorld = Class{
	__includes = LevelBase
}

function gameWorld:init()
   love.mouse.setVisible(false)
  
	LevelBase.init(self,'map.lua')
  Timer.every(5,function()  
      self:spawnEnemy()
    end )
  Timer.every(5, function()
      hshield = hshield + 1
      end)
end

function gameWorld:spawnHumanShield()
  if hshield > 0 then
  width, height = love.graphics.getDimensions( )
    xxx = love.mouse.getX() + king.x - (width/2) 
    yyy = love.mouse.getY() + king.y - (height/2)
    
    pointer = Pointer(self.world,king,xxx,yyy)
    LevelBase.Entities:add(pointer)
    
    kamikaze = Kamikaze(self.world,pointer,0,0)
    kamikaze.isEnemy = false;
   LevelBase.Entities:add(kamikaze)
   hshield = hshield - 1
   end
end

function gameWorld:spawnEnemy()
    from = love.math.random(0,3)
    if from == 0 then
      x = -100
      y = love.math.random(0,3200)
    end
      if from == 1 then
      x = 3200
      y = love.math.random(0,3200)
    end
      if from == 2 then
      x = love.math.random(0,3200)
      y = -100
    end
      if from == 3 then
      x = love.math.random(0,3200)
      y = 3200
    end
    kamikaze = Kamikaze(self.world,mechoui,x,y)
    kamikaze.isEnemy = true;
   LevelBase.Entities:add(kamikaze)
end
function gameWorld:spawnKamikaze()
    kamikaze = Kamikaze(self.world,king,king.x,-200)
    kamikaze.isEnemy = false;
   LevelBase.Entities:add(kamikaze)
end

function gameWorld:enter()
	--spawn entity from map data 
	gameWorld:spawn()
	
end

function gameWorld:update(dt)
  Timer.update(dt)
	self.map:update(dt)
  
	LevelBase.Entities:update(dt)
  
  if Control.getCommand() == 1 then
    gameWorld:spawnHumanShield()
    end
  
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
  Ui.draw(hshield,0,0,0)
  Control.draw()
end


function gameWorld:mousepressed(x,y,button,istouch)
     if button == 1 then
        self:spawnHumanShield()
      end
end

--spawn objects in the world using map data or entity
function gameWorld:spawn(objects)
	local obj = objects or self.map.objects
 for k, object in pairs(obj) do
		if object.name == "theKing" then
			king = Theking(self.world,object.x,object.y)
	LevelBase.Entities:add(king)  
  end
  if object.name == "kamikaze" then
    kamikaze = Kamikaze(self.world,king,object.x,object.y)
    kamikaze.isEnemy = true;
   LevelBase.Entities:add(kamikaze)
 end
if object.name == "mechoui" then
  mechoui = Mechoui(self.world,king,object.x,object.y)
  LevelBase.Entities:add(mechoui)
  end
 end
end

return gameWorld