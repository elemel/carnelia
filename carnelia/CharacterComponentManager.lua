local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.parentConstraintComponents = assert(self.game.componentManagers.parentConstraint)
  self.bodyComponents = assert(self.game.componentManagers.body)
  self.directionXs = {}
end

function M:createComponent(id, config)
  self.directionXs[id] = config.directionX or 1
end

function M:destroyComponent(id, config)
  self.directionXs[id] = nil
end

function M:setDirectionX(id, directionX)
  if directionX ~= self.directionXs[id] then
    self.directionXs[id] = directionX
    self.bodyComponents.localTransforms[id]:scale(-1, 1)
  end
end

return M
