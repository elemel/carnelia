local heart = require("heart")

local M = heart.class.newClass()

function M:init()
  self.elements = {}
end

function M:push(r, g, b, a)
  local r2, g2, b2, a2 = love.graphics.getColor()

  table.insert(self.elements, r2)
  table.insert(self.elements, g2)
  table.insert(self.elements, b2)
  table.insert(self.elements, a2)

  love.graphics.setColor(r, g, b, a)
end

function M:pop()
  local r, g, b, a = love.graphics.getColor()

  local a2 = table.remove(self.elements)
  local b2 = table.remove(self.elements)
  local g2 = table.remove(self.elements)
  local r2 = table.remove(self.elements)

  love.graphics.setColor(r2, g2, b2, a2)
  return r, g, b, a
end

return M
