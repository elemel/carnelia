local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transforms = {}
end

function M:createComponent(id, config)
  local transform = self.boneComponents.transforms[id]
  self.transforms[id] = transform:clone()
end

function M:destroyComponent(id)
  self.transforms[id] = nil
end

return M
