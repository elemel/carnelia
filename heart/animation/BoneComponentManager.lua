local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.transforms = {}
  self.previousTransforms = {}
end

function M:createComponent(id, config)
  local transform = love.math.newTransform()

  if config.transform then
    transform:setTransformation(unpack(config.transform))
  end

  if config.z then
    local zTransform = love.math.newTransform()

    zTransform:setMatrix(
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, config.z,
      0, 0, 0, 1)

    transform:apply(zTransform)
  end

  local parentId = self.game.entityParents[id]
  local parentTransform = parentId and self.transforms[parentId]

  if parentTransform then
    transform = parentTransform * transform
  end

  self.transforms[id] = transform
  self.previousTransforms[id] = transform:clone()
end

function M:destroyComponent(id)
  self.transforms[id] = nil
  self.previousTransforms[id] = nil
end

return M
