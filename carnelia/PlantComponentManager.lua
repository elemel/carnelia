local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.localXs = {}
  self.localYs = {}

  self.localNormalXs = {}
  self.localNormalYs = {}
end

function M:createComponent(id, config)
  self.localXs[id] = config.localX or 0
  self.localYs[id] = config.localY or 0

  self.localNormalXs[id] = config.localNormalX or 1
  self.localNormalYs[id] = config.localNormalY or 0
end

function M:destroyComponent(id, config)
  self.localXs[id] = nil
  self.localYs[id] = nil

  self.localNormalXs[id] = nil
  self.localNormalYs[id] = nil
end

return M
