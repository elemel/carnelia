local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.directionXs = {}
  self.states = {}
end

function M:createComponent(id, config)
  self.directionXs[id] = config.directionX or 1
  self.states[id] = config.state or "falling"
end

function M:destroyComponent(id, config)
  self.directionXs[id] = nil
  self.states[id] = nil
end

return M
