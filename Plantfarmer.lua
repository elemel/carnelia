local class = require("class")
local Walker = require("Walker")

local M = class.new()

function M:init(game, config)
  self.game = assert(game)

  self.walker = Walker.new(self.game, {
    x = config.x,
    y = config.y,
  })
end

function M:destroy()
  self.walker:destroy()
end

return M
