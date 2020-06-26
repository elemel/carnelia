local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local minX = -50
  local minY = -20

  local maxX = 50
  local maxY = 20

  for y = minY, maxY do
    love.graphics.line(minX, y, maxX, y)
  end

  for x = minX, maxX do
    love.graphics.line(x, minY, x, maxY)
  end

  love.graphics.setColor(r, g, b, a)
end

return M
