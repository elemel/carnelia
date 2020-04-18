local class = require("class")

local M = class.new()

function M:init(game, image, transform, z)
  self.game = assert(game)
  self.image = assert(image)
  self.transform = transform or love.math.newTransform()
  self.z = z or 0

  self.game.graphicsDomain.sprites[self] = true
end

function M:destroy()
  self.game.graphicsDomain.sprites[self] = nil
end

return M
