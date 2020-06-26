local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.fontSize = config.fontSize or 12
  self.font = love.graphics.newFont(self.fontSize)
  self.text = love.graphics.newText(self.font)
end

function M:handleEvent()
  local width, height = love.graphics.getDimensions()
  local fps = 1 / love.timer.getAverageDelta()
  local text = string.format("%.3g FPS", fps)
  self.text:set({self.color, text})
  love.graphics.draw(self.text, math.floor(0.5 * width - 0.5 * self.text:getWidth()), self.fontSize)
end

return M
