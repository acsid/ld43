local Control = {
  cursor = love.graphics.newImage("sprites/cursor.png") ,
  clicked = false
  
  }


function Control.goThere() 
  
  return x,y
end

function Control.update(dt)
  if Control.clicked == false then
    if love.mouse.isDown(1) then
          Control.clicked = true
    end
  end
end



function Control.getCommand()
  if Control.clicked == true then
    Control.clicked = false
    return 1
  end
  return 0
end

function Control.draw()
  love.graphics.draw(Control.cursor,love.mouse.getX(),love.mouse.getY())
end

return Control