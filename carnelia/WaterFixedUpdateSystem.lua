local heart = require("heart")
local polygon = require("carnelia.polygon")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.waterEntities = assert(self.game.componentEntitySets.water)
end

function M:handleEvent(dt)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(0.25, 0.5, 0.75, 0.25)

  local gravityX, gravityY = self.physicsDomain.world:getGravity()
  local bodies = self.physicsDomain.bodies
  local rectangleFixtures = self.physicsDomain.rectangleFixtures

  for id in pairs(self.waterEntities) do
    local waterBody = bodies[id]
    local waterFixture = rectangleFixtures[id]
    local waterShape = waterFixture:getShape()

    local minX, minY, maxX, maxY =
      heart.math.bounds2({waterBody:getWorldPoints(waterShape:getPoints())})

    for _, contact in ipairs(waterBody:getContacts()) do
      local fixture1, fixture2 = contact:getFixtures()

      if fixture2 == fixture then
        fixture1, fixture2 = fixture2, fixture1
      end

      local body = fixture2:getBody()
      local shape = fixture2:getShape()

      if shape:getType() == "polygon" then
        local points = {fixture2:getBody():getWorldPoints(shape:getPoints())}
        local clippedPoints = polygon.clipByLine(points, minX, minY, maxX, minY)

        if #clippedPoints >= 6 then
          local x, y, area = polygon.centroid(clippedPoints)
          body:applyForce(0, -gravityY * area * 2, x, y)
        end
      end
    end
  end

  love.graphics.setColor(r, g, b, a)
end

return M
