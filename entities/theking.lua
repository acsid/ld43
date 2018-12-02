--TheKing the most important 

local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local theking = Class{
	__includes = Entity -- inherit Entity class
}


function theking:init(world,x,y) 
  
  self.sprite = love.graphics.newImage("sprites/theking.png")
   
  
  Entity.init(self,world,x,y,self.sprite:getWidth(),self.sprite:getHeight()) --hard coded king size
  
  --king variables
  
  self.xVelocity = 0
  self.yVelocity = 0
  self.acc = 25 
  self.maxSpeed = 100 --Top speed of the king
  
  self.friction = 20 --friction
  
  self.isPlayer = true
  
  --sprite 

  
  self.world:add(self,self:getRect())
end

function theking:collisionFilter(other)
local x,y,w,h = self.world:getRect(other)
if other.isEnemy then
  return 'cross'
end
return 'slide'
end

function theking:update(dt)
    local prevX, prevY = self.x, self.y
    
    --apply friction
    
    self.xVelocity = self.xVelocity * (1 - math.min(dt * self.friction,1))
    self.yVelocity = self.yVelocity * ( 1 - math.min(dt * self.friction,1))
    
    
    --player inputs
    if love.keyboard.isDown("left" , "a") and self.xVelocity > -self.maxSpeed then
      self.xVelocity = self.xVelocity - self.acc * dt
    end
    if love.keyboard.isDown("right" , "d") and self.xVelocity < self.maxSpeed then
      self.xVelocity = self.xVelocity + self.acc *dt
    end
    if love.keyboard.isDown("up" , "w") and self.yVelocity < self.maxSpeed then
      self.yVelocity = self.yVelocity - self.acc *dt
    end
    if love.keyboard.isDown("down" , "s") and self.yVelocity > -self.maxSpeed then
      self.yVelocity = self.yVelocity + self.acc *dt
    end

    
    local goalX = self.x + self.xVelocity
    local goalY = self.y + self.yVelocity
    self.x , self.y, collisions, len = self.world:move(self,goalX,goalY,self.collisionFilter)
  
    end
    
    function theking:draw()
      love.graphics.print(self.x,self.x,self.y-64)
      love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
      end
    return theking