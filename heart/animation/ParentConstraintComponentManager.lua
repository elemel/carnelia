local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.boneComponents = assert(self.game.componentManagers.bone)
  self.localTransforms = {}
  self.enabledFlags = {}
end

function M:createComponent(entityId, config)
  local parentId = self.game.entityParents[entityId]
  local parentTransform = self.boneComponents.transforms[parentId]
  local transform = self.boneComponents.transforms[entityId]
  local localTransform = parentTransform:inverse():apply(transform)
  self.localTransforms[entityId] = localTransform
  self.enabledFlags[entityId] = config.enabled ~= false
  return localTransform
end

function M:destroyComponent(entityId)
  self.localTransforms[entityId] = nil
  self.enabledFlags[entityId] = nil
end

return M
