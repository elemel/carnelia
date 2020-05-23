local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.directionXs = {}
end

function M:createComponent(id, config)
  self.directionXs[id] = config.directionX or 1
end

function M:destroyComponent(id, config)
  self.directionXs[id] = nil
end

return M