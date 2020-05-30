local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.transformComponents = assert(self.game.componentManagers.transform)
  self.parentConstraintComponents = assert(self.game.componentManagers.parentConstraint)
  self.bodyComponents = assert(self.game.componentManagers.body)

  self.directionXs = {}
  self.inputXs = {}

  self.targetXs = {}
  self.targetYs = {}
end

function M:createComponent(id, config)
  self.directionXs[id] = config.directionX or 1
  self.inputXs[id] = config.inputX or 0

  self.targetXs[id] = config.targetX or 0
  self.targetYs[id] = config.targetY or 0
end

function M:destroyComponent(id, config)
  self.directionXs[id] = nil
  self.inputXs[id] = nil

  self.targetXs[id] = nil
  self.targetYs[id] = nil
end

function M:setDirectionX(id, directionX)
  if directionX ~= self.directionXs[id] then
    self.directionXs[id] = directionX
    self.bodyComponents.localTransforms[id]:scale(-1, 1)
  end
end

return M
