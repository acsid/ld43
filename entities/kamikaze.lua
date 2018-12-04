--1st enemy
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local kamikaze = Class{
	__includes = Entity -- inherit Entity Class
}

--init zombie
function kamikaze:init(world,king,x,y)

	
  self.king = king
	--Zombie Variables
	self.xVelocity = 0
	self.yVelocity = 0
	self.direction = 0 --moving direction
	self.maxSpeed = 200 --max moving speed
	self.acc  = 45
	self.isEnemy = true
  self.isDefend = false
  self.isBomber = false
  self.isFaster = false
  self.isAttacking = false
  self.isBuzy = false
  self.isHumanShield = false
	self.isMechoui = false
  self.isGrounded = false
	self.friction = 20

	self.hp = 3
	self.maxHp = 3
  
  self.hit = 1
  self.critical = 3
  self.radius = 32

  --sprites
   self.sprite = love.graphics.newImage("sprites/kamikaze1.png") 
  Entity.init(self,world,x,y,self.sprite:getWidth(),self.sprite:getHeight())
	--add self to world
	self.world:add(self,self:getRect())
end

function kamikaze:collisionFilter(other)
	local x, y, w, h = self.world:getRect(other)
	local playerBottom = self.y + self.h
	local otherBottom = y + h
	--print(other.isPlayer);
  if self.isEnemy == true then
    if other.isEnemy == false then
      self.hp = 0
      other.hp = 0
      if other.king.isPlayer == false then
        other.king.hp = 0
      end
    end
    if other.isMechoui == true then
      self.hp = 0
      other.hp = other.hp - 1
    end
  end
  if other.isEntity == true then
    if other.isPointer == true then
      if self.king == other then
        other.hp = 0
        self.isDefend = true
          self.sprite = love.graphics.newImage("sprites/humanshield.png") 
      end
      return 'cross'
    end
  if other.isPlayer == true then
    return 'cross'
  else
    return 'cross'
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
	
  
  if self.isDefend == false then
  if self.isEnemy == false then

    if distance(self.x,self.y,self.king.x + self.king.sprite:getWidth() / 2,self.king.y + self.king.sprite:getHeight() / 2) < 400 and king.isPointer == false then
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



--if is enemy

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
end
	--set goal position
	local goalX = self.x + self.xVelocity
	local goalY = self.y + self.yVelocity
	self.x , self.y, collisions, len = self.world:move(self,goalX, goalY, self.collisionFilter)
  
  	for i, coll in ipairs(collisions) do
		 
	end
  
 
	

end

local trans =  love.math.newTransform()
function kamikaze:draw()
	--placeholder
	--love.graphics.rectangle("fill",self.x,self.y,16,32)
  if  self.xVelocity < 0 then
    love.graphics.draw(self.sprite,math.floor(self.x+self.sprite:getWidth()),math.floor(self.y),0,-1,1)
  else
  love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
  end
  love.graphics.printf(('h: %s'):format(self.hp),self.x,self.y,10,"center")
end

return kamikaze