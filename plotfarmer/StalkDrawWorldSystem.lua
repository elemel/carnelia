local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.plantEntities = assert(self.game.componentEntitySets.plant)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:__call(viewportId)
  local lineWidth = love.graphics.getLineWidth()
  local lineJoin = love.graphics.getLineJoin()
  local r, g, b, a = love.graphics.getColor()

  love.graphics.setLineWidth(0.2)
  love.graphics.setLineJoin("none")
  love.graphics.setColor(0.6, 0.8, 0.2, 1)

  local transforms = self.transformComponents.transforms

  for id in pairs(self.plantEntities) do
    local parentId = self.game.entityParents[id]
    local x1, y1 = transforms[parentId]:transformPoint(-0.6, -0.8)
    local x2, y2 = transforms[parentId]:transformPoint(-1, -2.8)
    local x3, y3 = transforms[id]:transformPoint(-2.5, 0)
    local x4, y4 = transforms[id]:transformPoint(-0.5, 0)

    local curve = love.math.newBezierCurve(x1, y1, x2, y2, x3, y3, x4, y4)
    love.graphics.line(curve:render())
  end

  love.graphics.setColor(r, g, b, a)
  love.graphics.setLineJoin(lineJoin)
  love.graphics.setLineWidth(lineWidth)
end

return M
