local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.parentConstraintComponents = assert(self.game.componentManagers.parentConstraint)
  self.bodyComponents = assert(self.game.componentManagers.body)

  self.directionXs = {}

  self.inputXs = {}
  self.inputYs = {}

  self.targetXs = {}
  self.targetYs = {}

  self.headYs = {}

  self.shoulderWidths = {}
  self.shoulderYs = {}

  self.armLengths = {}

  self.hipWidths = {}
  self.hipYs = {}

  self.legLengths = {}
end

function M:createComponent(id, config)
  self.directionXs[id] = config.directionX or 1

  self.inputXs[id] = config.inputX or 0
  self.inputYs[id] = config.inputY or 0

  self.targetXs[id] = config.targetX or 0
  self.targetYs[id] = config.targetY or 0

  self.headYs[id] = config.headY or -0.55

  self.shoulderWidths[id] = config.shoulderWidth or 0.3
  self.shoulderYs[id] = config.shoulderY or -0.3

  self.armLengths[id] = config.armLength or 0.75

  self.hipWidths[id] = config.hipWidth or 0.2
  self.hipYs[id] = config.hipY or 0.3

  self.legLengths[id] = config.legLength or 1
end

function M:destroyComponent(id, config)
  self.directionXs[id] = nil

  self.inputXs[id] = nil
  self.inputYs[id] = nil

  self.targetXs[id] = nil
  self.targetYs[id] = nil

  self.headYs[id] = nil

  self.shoulderWidths[id] = nil
  self.shoulderYs[id] = nil

  self.armLengths[id] = nil

  self.hipWidths[id] = nil
  self.hipYs[id] = nil

  self.legLengths[id] = nil
end

function M:setDirectionX(id, directionX)
  if directionX ~= self.directionXs[id] then
    self.directionXs[id] = directionX
    self.bodyComponents.localTransforms[id]:scale(-1, 1)
  end
end

return M
