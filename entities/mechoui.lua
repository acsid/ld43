local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local mechoui = Class{
	__includes = Entity -- inherit Entity Class
}


function mechoui:init(world,king,x,y)
  
  self.king = king
  self.isMechoui = true
  self.sprite = love.graphics.newImage("sprites/mechoui.png") 
    Entity.init(self,world,x,y,self.sprite:getWidth(),self.sprite:getHeight())
self.hp = 10
	self.maxHp = 10
	--add self to world
	self.world:add(self,self:getRect())
end

function mechoui:update()
  if self.hp == 0 then
  gameover()
  end
end




function mechoui:draw()
	--placeholder
	--love.graphics.rectangle("fill",self.x,self.y,16,32)
  
  love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
  love.graphics.printf(('h: %s'):format(self.hp),self.x,self.y,10,"center")
end

return mechoui