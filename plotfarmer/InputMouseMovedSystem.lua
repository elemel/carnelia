local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.inputDomain = assert(self.game.domains.input)
end

function M:__call(x, y, dx, dy, istouch)
  self.inputDomain.accumulatedMouseDx = self.inputDomain.accumulatedMouseDx + dx
  self.inputDomain.accumulatedMouseDy = self.inputDomain.accumulatedMouseDy + dy
end

return M
