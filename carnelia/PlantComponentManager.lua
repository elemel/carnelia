local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.localXs = {}
  self.localYs = {}
end

function M:createComponent(id, config)
  self.localXs[id] = config.localX or 0
  self.localYs[id] = config.localY or 0
end

function M:destroyComponent(id, config)
  self.localXs[id] = nil
  self.localYs[id] = nil
end

return M
