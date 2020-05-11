local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.accumulatedMouseDx = 0
  self.accumulatedMouseDy = 0
end

return M
