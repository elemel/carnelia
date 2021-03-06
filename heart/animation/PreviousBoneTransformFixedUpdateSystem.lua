local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.boneComponents = assert(self.game.componentManagers.bone)
end

function M:handleEvent(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.boneComponents.transforms

  for id in pairs(self.boneEntities) do
    previousTransforms[id]:reset():apply(transforms[id])
  end
end

return M
