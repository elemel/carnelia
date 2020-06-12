local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.parentConstraintEntities =
    assert(self.game.componentEntitySets.parentConstraint)

  self.boneComponents = assert(self.game.componentManagers.bone)

  self.parentConstraintComponents =
    assert(self.game.componentManagers.parentConstraint)
end

function M:handleEvent(dt)
  local parents = self.game.entityParents
  local transforms = self.boneComponents.transforms
  local localTransforms = self.parentConstraintComponents.localTransforms
  local enabledFlags = self.parentConstraintComponents.enabledFlags

  -- TODO: Topological sort
  for id in pairs(self.parentConstraintEntities) do
    if enabledFlags[id] then
      local parentId = parents[id]

      transforms[id]:
        reset():
        apply(transforms[parentId]):
        apply(localTransforms[id])
    end
  end
end

return M
