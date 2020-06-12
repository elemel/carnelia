local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.physicsDomain = assert(self.game.domains.physics)
  self.timerDomain = assert(self.game.domains.timer)

  self.plantEntities = assert(self.game.componentEntitySets.plant)
  self.upperEntities = assert(self.game.componentEntitySets.upper)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.characterComponents = assert(self.game.componentManagers.character)
  self.parentConstraintComponents = assert(self.game.componentManagers.parentConstraint)
  self.plantComponents = assert(self.game.componentManagers.plant)
  self.plantStateComponents = assert(self.game.componentManagers.plantState)
end

function M:handleEvent(dt)
  local fixedTime = self.timerDomain:getFixedTime()

  -- TODO: Use proper states instead of polling mouse
  local mouseDown = love.mouse.isDown(1)

  local bodies = self.physicsDomain.bodies

  local distanceJoints = self.physicsDomain.distanceJoints
  local ropeJoints = self.physicsDomain.ropeJoints

  local transforms = self.boneComponents.transforms
  local localTransforms = self.parentConstraintComponents.localTransforms
  local directionXs = self.characterComponents.directionXs
  local states = self.plantStateComponents.states

  local localXs = self.plantComponents.localXs
  local localYs = self.plantComponents.localYs

  local localNormalXs = self.plantComponents.localNormalXs
  local localNormalYs = self.plantComponents.localNormalYs

  for id in pairs(self.plantEntities) do
    local parentId = self.game.entityParents[id]

    if states[id] == "vaulting" then
      local x1, y1, x2, y2 = distanceJoints[id]:getAnchors()
      local body1, body2 = distanceJoints[id]:getBodies()

      local normalX, normalY = body1:getWorldVector(localNormalXs[id], localNormalYs[id])
      local angle = math.atan2(normalY, normalX) + math.pi

      transforms[id]:setTransformation(x1, y1, angle, 1, directionXs[parentId])

      for childId in pairs(self.game.entityChildSets[id]) do
        local directionY = self.upperEntities[childId] and -1 or 1
        localTransforms[childId]:setTransformation(0, 0, directionY * 0.375 * math.pi)
      end
    elseif states[id] == "swinging" then
      local x1, y1, x2, y2 = ropeJoints[id]:getAnchors()
      local body1, body2 = ropeJoints[id]:getBodies()

      local normalX, normalY = body1:getWorldVector(localNormalXs[id], localNormalYs[id])
      local angle = math.atan2(normalY, normalX) + math.pi

      transforms[id]:setTransformation(x1, y1, angle, 1, directionXs[parentId])

      for childId in pairs(self.game.entityChildSets[id]) do
        local directionY = self.upperEntities[childId] and -1 or 1
        localTransforms[childId]:setTransformation(0, 0, directionY * 0.375 * math.pi)
      end
    else
      local angle = math.atan2(localYs[id], localXs[id])
      local parentX, parentY = bodies[parentId]:getPosition()

      transforms[id]:setTransformation(
        parentX + localXs[id], parentY + localYs[id], angle, 1, directionXs[parentId])

      local jawAngle = mouseDown and 0 or 0.1875 * math.pi

      for childId in pairs(self.game.entityChildSets[id]) do
        local directionY = self.upperEntities[childId] and -1 or 1
        localTransforms[childId]:setTransformation(0, 0, directionY * jawAngle)
      end
    end
  end
end

return M
