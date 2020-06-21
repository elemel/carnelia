local heart = require("heart")

local ColorStack = require("carnelia.ColorStack")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.colorStack = ColorStack.new()
end

function M:handleEvent(viewportId)
  self.colorStack:push(unpack(self.color))

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

  self.colorStack:pop()
end

return M
