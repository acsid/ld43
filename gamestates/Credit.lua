
Credit = Gamestate.new()

function Credit:enter()
self.sprite = love.graphics.newImage("sprites/credits.png") 
end

function Credit:draw()
	local w,h = love.graphics.getWidth(), love.graphics.getHeight()
	--draw previous screen
	
	  -- overlay with pause message
  	love.graphics.setColor(0,0,0, 25)
  	love.graphics.rectangle('fill', 0,0, w, h)
  	love.graphics.setColor(255,255,255)
  	 love.graphics.draw(self.sprite,0,0)
    -- love.graphics.print("press N to start a new game",0,0)
end

function Credit:keypressed(key)
  	if key == 'n' then
   		return Gamestate.switch(gameWorld) -- return to previous state
 	end
end

return Credit