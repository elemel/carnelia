local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.boneComponents = assert(self.game.componentManagers.bone)

  self.imageLoader = assert(game.resourceLoaders.image)
  self.linearImageLoader = assert(game.resourceLoaders.linearImage)

  self.images = {}
  self.normalMaps = {}

  self.transforms = {}
  self.zs = {}
end

function M:createComponent(id, config)
  local transform = self.boneComponents.transforms[id]

  if config.image then
    self.images[id] = self.imageLoader:loadResource(config.image)
  end

  if config.normalMap then
    self.normalMaps[id] = self.linearImageLoader:loadResource(config.normalMap)
  end

  self.transforms[id] = transform:clone()
  self.zs[id] = config.z or 0
end

function M:destroyComponent(id)
  self.images[id] = nil
  self.normalMaps[id] = nil
  self.transforms[id] = nil
  self.zs[id] = nil
end

return M
