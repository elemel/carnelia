local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.imageLoader = assert(self.game.resourceLoaders.image)
  self.skyGradientImage = self.imageLoader:loadResource("carnelia/resources/images/skyGradient.png")
  self.skyGradientImage:setFilter("linear", "linear")
end

function M:handleEvent()
  local width, height = love.graphics.getDimensions()
  love.graphics.draw(self.skyGradientImage, -0.5 * width, -0.5 * height, 0, width, height)
end

return M
