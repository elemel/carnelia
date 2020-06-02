local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
end

function M:handleEvent(viewportId)
  local transforms = self.spriteComponents.transforms
  local ids = heartTable.keys(self.spriteEntities)
  local zs = self.spriteComponents.zs
  local epsilon = 1e-6

  table.sort(ids, function(a, b)
    return zs[a] + a * epsilon < zs[b] + b * epsilon
  end)

  local images = self.spriteComponents.images

  for _, id in ipairs(ids) do
    love.graphics.draw(images[id], transforms[id])
  end
end

return M
