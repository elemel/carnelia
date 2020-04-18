local class = require("class")

local M = class.new()

function M:init(config)
  self.x = config.x or 0
  self.y = config.y or 0

  self.scale = config.scale or 1

  self.viewportX = config.viewportX or 0
  self.viewportY = config.viewportY or 0

  self.viewportWidth = config.viewportWidth or 1
  self.viewportHeight = config.viewportHeight or 1

  self.transform = love.math.newTransform()
  self:updateTransform()
end

function M:updateTransform()
  self.transform:reset()

  self.transform:translate(
    self.viewportX + 0.5 * self.viewportWidth,
    self.viewportY + 0.5 * self.viewportHeight)

  self.transform:scale(self.scale * self.viewportHeight)
  self.transform:translate(-self.x, -self.y)
end

function M:applyTransform()
  love.graphics.applyTransform(self.transform)
  love.graphics.setLineWidth(1 / (self.scale * self.viewportHeight))
end

return M
