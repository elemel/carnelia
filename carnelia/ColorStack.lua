local heart = require("heart")

local M = heart.class.newClass()

function M:init()
  self.colors = {}
end

function M:push(r, g, b, a)
  table.insert(self.colors, {love.graphics.getColor()})
  love.graphics.setColor(r, g, b, a)
end

function M:pop()
  love.graphics.setColor(table.remove(self.colors))
end

return M
