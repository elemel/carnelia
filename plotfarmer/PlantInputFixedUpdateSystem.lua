local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.inputDomain = assert(self.game.domains.input)
  self.physicsDomain = assert(self.game.domains.physics)

  self.plantEntities = assert(self.game.componentEntitySets.plant)

  self.parentConstraintComponents =
    assert(self.game.componentManagers.parentConstraint)
end

function M:__call(dt)
  local localTransforms = self.parentConstraintComponents.localTransforms

  local dx = self.inputDomain.accumulatedMouseDx
  local dy = self.inputDomain.accumulatedMouseDy

  self.inputDomain.accumulatedMouseDx = 0
  self.inputDomain.accumulatedMouseDy = 0

  local sensitivity = 0.01

  for id in pairs(self.plantEntities) do
    local localTransform = localTransforms[id]
    local x, y = localTransform:transformPoint(0, 0)

    x = x + sensitivity * dx
    y = y + sensitivity * dy

    x, y = heart.math.clampLength2(x, y, 0, 4)

    localTransform:setTransformation(x, y)
  end
end

return M
