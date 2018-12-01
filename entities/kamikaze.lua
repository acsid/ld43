--1st enemy
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local kamikaze = Class{
	__includes = Entity -- inherit Entity Class
}

--init zombie
function kamikaze:init(world,king,x,y)
	Entity.init(self,world,x,y,32,32) -- hard coded zombie size
	
  self.king = king
	--Zombie Variables
	self.xVelocity = 0
	self.yVelocity = 0
	self.direction = 0 --moving direction
	self.maxSpeed = 100 --max moving speed
	self.acc  = 10
	self.isEnemy = true
	
  self.isGrounded = false
	self.friction = 20

	self.hp = 3
	self.maxHp = 3

  --sprites
   self.sprite = love.graphics.newImage("sprites/kamikaze1.png") 

	--add self to world
	self.world:add(self,self:getRect())
end

function kamikaze:collisionFilter(other)
	local x, y, w, h = self.world:getRect(other)
	local playerBottom = self.y + self.h
	local otherBottom = y + h
	--print(other.isPlayer);
  if other.isEntity == true then
  if other.isPlayer == true then
    return 'cross'
  else
    return 'slide'
  end
  end
	if playerBottom <= y then
		return 'slide'
	end
	if self.x + self.w <= x then
	self.direction = 0
		return 'slide'
	end
	if self.x >= x then
	self.direction = 1
		return 'slide'
	end
	--return slide collision by default
	return 'slide'
end

function kamikaze:update(dt)
	local prevX , prevY = self.x, self.y
	--apply friction
	self.xVelocity = self.xVelocity * ( 1 - math.min(dt * self.friction,1))
	self.yVelocity = self.yVelocity * ( 1 - math.min(dt * self.friction,1))
	
  

    if distance(self.x,self.y,self.king.x,self.king.y) < 60 then
       if self.x < self.king.x then
       self.xVelocity = self.xVelocity - self.acc * dt

  else
     self.xVelocity = self.xVelocity + self.acc * dt
  end
  if self.y < self.king.y then
    self.yVelocity = self.yVelocity - self.acc * dt
  else
     self.yVelocity = self.yVelocity + self.acc * dt
  end
    else
    
   if self.x < self.king.x then
       self.xVelocity = self.xVelocity + self.acc * dt

  else
     self.xVelocity = self.xVelocity - self.acc * dt
  end
  if self.y < self.king.y then
    self.yVelocity = self.yVelocity + self.acc * dt
  else
     self.yVelocity = self.yVelocity - self.acc * dt
  end
  end




	--set goal position
	local goalX = self.x + self.xVelocity
	local goalY = self.y + self.yVelocity
	self.x , self.y, collisions, len = self.world:move(self,goalX, goalY, self.collisionFilter)
  
  	for i, coll in ipairs(collisions) do
		
	end
  
  
	

end

function kamikaze:draw()
	--placeholder
	--love.graphics.rectangle("fill",self.x,self.y,16,32)
  
  love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
  love.graphics.printf(('h: %s'):format(distance(self.x,self.y,self.king.x,self.king.y)),self.x,self.y,10,"center")
end

return kamikaze