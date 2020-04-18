local class = require("class")

local M = class.new()

function M:init(game, config)
  self.sprites = {}
end

function M:draw()
  local sortedSprites = {}

  for sprite in pairs(self.sprites) do
    sortedSprites[#sortedSprites + 1] = sprite
  end

  table.sort(sortedSprites, function(a, b) return a.z < b.z end)

  for i, sprite in ipairs(sortedSprites) do
    love.graphics.draw(sprite.image, sprite.transform)
  end
end

return M
