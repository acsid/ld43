local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local pointer = Class{
	__includes = Entity -- inherit Entity Class
}


function pointer:init(world,king,x,y)
    self.yOffset = 10
    self.isPointer = true
 --sprites
   self.sprite = love.graphics.newImage("sprites/actionPointer.png") 
  Entity.init(self,world,x,y,self.sprite:getWidth(),self.sprite:getHeight())
	--add self to world
	self.world:add(self,self:getRect())

end

function pointer:update(dt)
    self.yOffset = self.yOffset-0.1
    if self.yOffset < 0 then
      self.yOffset = 10
    end
  end

function pointer:draw()
     love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y-self.yOffset))
end

 
return pointer