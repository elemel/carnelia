local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.waterEntities = assert(self.game.componentEntitySets.water)
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(0.25, 0.5, 0.75, 0.25)

  local rectangleFixtures = self.physicsDomain.rectangleFixtures

  for id in pairs(self.waterEntities) do
    local fixture = rectangleFixtures[id]
    local body = fixture:getBody()
    local shape = fixture:getShape()
    love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
  end

  love.graphics.setColor(r, g, b, a)
end

return M
