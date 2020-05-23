local heart = require("heart")
local inverseKinematics = require("carnelia.inverseKinematics")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.physicsDomain = assert(self.game.domains.physics)
  self.timerDomain = assert(self.game.domains.timer)

  self.footEntities = assert(self.game.componentEntitySets.foot)
  self.leftEntities = assert(self.game.componentEntitySets.left)

  self.characterStateComponents = assert(self.game.componentManagers.characterState)
  self.raySensorComponents = assert(self.game.componentManagers.raySensor)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:handleEvent(dt)
  local fixedTime = self.timerDomain:getFixedTime()
  local transforms = self.transformComponents.transforms
  local states = self.characterStateComponents.states

  for id in pairs(self.footEntities) do
    local lowerLegId = self.game.entityParents[id]
    local upperLegId = self.game.entityParents[lowerLegId]
    local characterId = self.game.entityParents[upperLegId]
    local side = self.leftEntities[upperLegId] and -1 or 1
    local state = states[characterId]

    local contact = self.raySensorComponents.contacts[characterId]
    local characterBody = self.physicsDomain.bodies[characterId]
    local hipX, hipY = characterBody:getWorldPoint(side * 0.125, 0.3)

    local groundX, groundY, groundNormalX, groundNormalY

    if contact then
      groundX = contact.x
      groundY = contact.y

      groundNormalX = contact.normalX
      groundNormalY = contact.normalY
    else
      groundX, groundY = characterBody:getWorldPoint(0, 1)

      groundNormalX = 0
      groundNormalY = -1
    end

    local groundTangentX = groundNormalY
    local groundTangentY = -groundNormalX

    if state == "standing" then
      footX = groundX - side * groundTangentX * 0.375
      footY = groundY - side * groundTangentY * 0.375
    else
      local angle = 10 * fixedTime + side * 0.5 * math.pi
      footX = groundX + groundTangentX * 0.5 * math.cos(angle) + groundNormalX * 0.25 * math.max(0, 0.5 + math.sin(angle))
      footY = groundY + groundTangentY * 0.5 * math.cos(angle) + groundNormalY * 0.25 * math.max(0, 0.5 + math.sin(angle))
    end

    local length = 1
    local kneeX, kneeY, footX, footY = inverseKinematics.solve(hipX, hipY, footX, footY, length)

    local distance = heart.math.distance2(hipX, hipY, footX, footY)
    local legAngle = math.atan2(footY - hipY, footX - hipX) - 0.5 * math.pi

    local kneeAngle = math.acos(math.min(distance / length, 1))

    local footAngle = math.atan2(groundNormalY, groundNormalX) + 0.5 * math.pi

    transforms[upperLegId]:setTransformation(hipX, hipY, legAngle - kneeAngle)
    transforms[lowerLegId]:setTransformation(kneeX, kneeY, legAngle + kneeAngle)
    transforms[id]:setTransformation(footX, footY, footAngle)
  end
end

return M
