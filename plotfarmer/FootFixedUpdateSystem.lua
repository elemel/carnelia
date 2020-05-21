local heart = require("heart")
local inverseKinematics = require("plotfarmer.inverseKinematics")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)

  self.footEntities = assert(self.game.componentEntitySets.foot)
  self.leftEntities = assert(self.game.componentEntitySets.left)

  self.characterStateComponents = assert(self.game.componentManagers.characterState)
  self.groundSensorComponents = assert(self.game.componentManagers.groundSensor)
  self.transformComponents = assert(self.game.componentManagers.transform)

  local size = 0.75

  self.corners = {
    {0.5 * size, 0},
    {0, 0.5 * size},
    {-0.5 * size, 0},
    {0, -0.5 * size},
  }
end

function M:__call(dt)
  local transforms = self.transformComponents.transforms
  local states = self.characterStateComponents.states

  for id in pairs(self.footEntities) do
    local lowerLegId = self.game.entityParents[id]
    local upperLegId = self.game.entityParents[lowerLegId]
    local characterId = self.game.entityParents[upperLegId]
    local side = self.leftEntities[upperLegId] and -1 or 1
    local state = states[characterId]

    local contact = self.groundSensorComponents.contacts[characterId]
    local characterBody = self.physicsDomain.bodies[characterId]
    local hipX, hipY = characterBody:getWorldPoint(side * 0.125, 0.25)

    for _, wheelId in ipairs(self.game:findDescendantComponents(characterId, "wheel")) do
      local wheelBody = self.physicsDomain.bodies[wheelId]

      local footX = 0
      local footY = -math.huge

      if state == "standing" then
        local x, y = wheelBody:getPosition()

        footX = contact.x - side * contact.normalY * 0.375
        footY = contact.y + side * contact.normalX * 0.375
      else
        for i, corner in ipairs(self.corners) do
          if (side == -1) == ((i % 2) == 0) then
            local x, y = wheelBody:getWorldPoint(unpack(corner))

            if y > footY then
              footX = x
              footY = y
            end
          end
        end
      end

      local length = 1
      local kneeX, kneeY, footX, footY = inverseKinematics.solve(hipX, hipY, footX, footY, length)

      local distance = heart.math.distance2(hipX, hipY, footX, footY)
      local legAngle = math.atan2(footY - hipY, footX - hipX) - 0.5 * math.pi

      local kneeAngle = math.acos(math.min(distance / length, 1))

      local footAngle = math.atan2(contact.normalY, contact.normalX) + 0.5 * math.pi

      transforms[upperLegId]:setTransformation(hipX, hipY, legAngle - kneeAngle)
      transforms[lowerLegId]:setTransformation(kneeX, kneeY, legAngle + kneeAngle)
      transforms[id]:setTransformation(footX, footY, footAngle)
    end
  end
end

return M
