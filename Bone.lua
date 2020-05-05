local class = require("class")

local M = class.new()

function M:init(game, transform)
  self.game = assert(game)
  self.transform = transform or love.math.newTransform()

  self.game.animationDomain.bones[self] = true
end

function M:destroy()
  self.game.animationDomain.bones[self] = nil
end

return M
