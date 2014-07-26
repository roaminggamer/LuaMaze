require "maze"
require "algorithms/perfect"

function drawMaze(maze, x, y, cellDim, wallDim, cellCol, wallCol)
  love.graphics.setColor(wallCol)
  local mazeWidth = (cellDim + wallDim) * #maze[1] + wallDim
  local mazeHeight = (cellDim + wallDim) * #maze + wallDim
  love.graphics.rectangle("fill", x, y, mazeWidth, mazeHeight)
  
  love.graphics.setColor(cellCol)
  for yi = 1, #maze do
    for xi = 1, #maze[1] do
      local posX = x + (cellDim + wallDim) * (xi - 1) + wallDim
      local posY = y + (cellDim + wallDim) * (yi - 1) + wallDim
      love.graphics.rectangle("fill", posX, posY, cellDim, cellDim)
      
      -- Need to redo this, badly...
      if maze[yi][xi].north:isOpened() then
        love.graphics.rectangle("fill", posX, posY - wallDim, cellDim, wallDim)
      end
      if maze[yi][xi].east:isOpened() then
        love.graphics.rectangle("fill", posX + cellDim, posY, wallDim, cellDim)
      end
      if maze[yi][xi].south:isOpened() then
        love.graphics.rectangle("fill", posX, posY + cellDim, cellDim, wallDim)
      end
      if maze[yi][xi].west:isOpened() then
        love.graphics.rectangle("fill", posX - wallDim, posY, wallDim, cellDim)
      end
    end
  end 
end

function love.load()
  maze = Maze:Create(25, 19, true)
end

function love.keyreleased(key)
  if key == "1" then
    Maze:Backtracker(maze)
  elseif key == "2" then
    Maze:Prim(maze)
  elseif key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.setBackgroundColor(100, 100, 200)
  drawMaze(maze, 10, 10, 20, 10, { 150, 150, 200 }, { 20, 20, 100 })
end