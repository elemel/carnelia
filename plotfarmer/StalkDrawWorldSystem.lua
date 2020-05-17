local heart = require("heart")

local M = heart.class.newClass()

local function transformPoint(previousTransforms, transforms, id, x, y, t)
  local x1, y1 = previousTransforms[id]:transformPoint(x, y)
  local x2, y2 = transforms[id]:transformPoint(x, y)
  return heart.math.mix2(x1, y1, x2, y2, t)
end

function M:init(game, system)
  self.game = assert(game)
  self.timerDomain = assert(self.game.domains.timer)
  self.plantEntities = assert(self.game.componentEntitySets.plant)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.boneComponents = assert(self.game.componentManagers.bone)
end

function M:__call(viewportId)
  local lineWidth = love.graphics.getLineWidth()
  local lineJoin = love.graphics.getLineJoin()
  local r, g, b, a = love.graphics.getColor()

  love.graphics.setLineWidth(0.15)
  love.graphics.setLineJoin("none")
  love.graphics.setColor(0.4, 0.8, 0.2, 1)

  local t = self.timerDomain.accumulatedDt / self.timerDomain.fixedDt
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms

  for id in pairs(self.plantEntities) do
    local parentId = self.game.entityParents[id]
    local x1, y1 = transformPoint(previousTransforms, transforms, parentId, -0.25, -0.8, t)
    local x2, y2 = transformPoint(previousTransforms, transforms, parentId, -0.25, -2.8, t)
    local x3, y3 = transformPoint(previousTransforms, transforms, id, -2.5, 0, t)
    local x4, y4 = transformPoint(previousTransforms, transforms, id, -0.5, 0, t)

    local curve = love.math.newBezierCurve(x1, y1, x2, y2, x3, y3, x4, y4)
    love.graphics.line(curve:render())
  end

  love.graphics.setColor(r, g, b, a)
  love.graphics.setLineJoin(lineJoin)
  love.graphics.setLineWidth(lineWidth)
end

return M
