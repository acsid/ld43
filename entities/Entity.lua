--Basic Entity system

local Class = require 'libs.hump.class'
anim8	= require 'libs.anim8'

local Entity = Class{}

function Entity:init(world, x, y , w, h,hp)
	self.world = world
	self.x = x
	self.y = y
	self.w = w
	self.h = h
  self.HP = hp or 1
  self.isEntity = true
end

function Entity:getRect()
	return self.x, self.y, self.w, self.h 
end

function Entity:draw()
	love.graphics.print(("x: %s y: %s"):format(self.x,self.y))
	--do nothing
end

function Entity:update(dt)
	--do nothing
end

function Entity:doDamage(hit)
  if self.hp == nil then
    return
  end
  
  self.HP = self.HP - hit
end
function Entity:getHP()
  return self.HP
end

function Entity:kill()
  --remove self from world
  self.world:remove(self)
end
return Entity