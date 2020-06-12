local heart = require("heart")

local M = heart.class.newClass()

local function transformPoint(previousTransforms, transforms, id, x, y, t)
  local x1, y1 = previousTransforms[id]:transformPoint(x, y)
  local x2, y2 = transforms[id]:transformPoint(x, y)
  return heart.math.mix2(x1, y1, x2, y2, t)
end

local function transformVector(previousTransforms, transforms, id, x, y, t)
  local x1, y1 = heart.math.transformVector2(previousTransforms[id], x, y)
  local x2, y2 = heart.math.transformVector2(transforms[id], x, y)
  return heart.math.mix2(x1, y1, x2, y2, t)
end

function M:init(game, system)
  self.game = assert(game)

  self.physicsDomain = assert(self.game.domains.physics)
  self.timerDomain = assert(self.game.domains.timer)

  self.plantEntities = assert(self.game.componentEntitySets.plant)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.characterComponents = assert(self.game.componentManagers.character)
  self.plantStateComponents = assert(self.game.componentManagers.plantState)
end

function M:handleEvent(viewportId)
  local lineWidth = love.graphics.getLineWidth()
  local lineJoin = love.graphics.getLineJoin()
  local r, g, b, a = love.graphics.getColor()

  love.graphics.setLineWidth(0.1)
  love.graphics.setLineJoin("none")
  love.graphics.setColor(0.4, 0.8, 0.2, 1)

  local t = self.timerDomain.accumulatedDt / self.timerDomain.fixedDt
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.boneComponents.transforms

  local bodies = self.physicsDomain.bodies
  local targetYs = self.characterComponents.targetYs
  local states = self.plantStateComponents.states

  for id in pairs(self.plantEntities) do
    local parentId = self.game.entityParents[id]
    local headX, headY = bodies[parentId]:getWorldPoint(0, -0.55)

    if states[id] == "vaulting" then
      local handX, handY = transformPoint(previousTransforms, transforms, parentId, 0, -1, t)
      local plantX, plantY = transformPoint(previousTransforms, transforms, id, 0, 0, t)

      local tangentX, tangentY, distance = heart.math.normalize2(plantX - handX, plantY - handY)
      love.graphics.line(handX, handY, plantX, plantY)

      local sandbagX, sandbagY = transformPoint(previousTransforms, transforms, parentId, -0.4, -0.7, t)
      local sandbagTangentX, sandbagTangentY = transformVector(previousTransforms, transforms, parentId, 0, -1, t)

      local curve = love.math.newBezierCurve(
        sandbagX, sandbagY, sandbagX + sandbagTangentX, sandbagY + sandbagTangentY,
        handX - 2 * tangentX, handY - 2 * tangentY, handX, handY)

      love.graphics.line(curve:render())
    else
      local shoulderX, shoulderY = transformPoint(previousTransforms, transforms, parentId, 0, -0.3, t)
      local plantX, plantY = transformPoint(previousTransforms, transforms, id, 0, 0, t)

      local tangentX, tangentY, distance = heart.math.normalize2(plantX - shoulderX, plantY - shoulderY)
      local handX = shoulderX + distance / 7.5 * 0.75 * tangentX
      local handY = shoulderY + distance / 7.5 * 0.75 * tangentY

      love.graphics.line(handX, handY, plantX, plantY)

      local sandbagX, sandbagY = transformPoint(previousTransforms, transforms, parentId, -0.4, -0.7, t)
      local sandbagTangentX, sandbagTangentY = transformVector(previousTransforms, transforms, parentId, 0, -1, t)

      local curve = love.math.newBezierCurve(
        sandbagX, sandbagY, sandbagX + sandbagTangentX, sandbagY + sandbagTangentY,
        handX - 2 * tangentX, handY - 2 * tangentY, handX, handY)

      love.graphics.line(curve:render())
    end
  end

  love.graphics.setColor(r, g, b, a)
  love.graphics.setLineJoin(lineJoin)
  love.graphics.setLineWidth(lineWidth)
end

return M
