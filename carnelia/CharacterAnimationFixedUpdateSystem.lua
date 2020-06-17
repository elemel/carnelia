local heart = require("heart")
local inverseKinematics = require("carnelia.inverseKinematics")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.physicsDomain = assert(self.game.domains.physics)
  self.timerDomain = assert(self.game.domains.timer)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.footEntities = assert(self.game.componentEntitySets.foot)
  self.handEntities = assert(self.game.componentEntitySets.hand)
  self.leftEntities = assert(self.game.componentEntitySets.left)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.characterComponents = assert(self.game.componentManagers.character)

  self.characterLowerStateComponents =
    assert(self.game.componentManagers.characterLowerState)

  self.characterUpperStateComponents =
    assert(self.game.componentManagers.characterUpperState)

  self.parentConstraintComponents =
    assert(self.game.componentManagers.parentConstraint)

  self.raySensorComponents = assert(self.game.componentManagers.raySensor)
end

function M:handleEvent(dt)
  local fixedTime = self.timerDomain:getFixedTime()

  local bodies = self.physicsDomain.bodies
  local transforms = self.boneComponents.transforms

  local lowerStates = self.characterLowerStateComponents.states
  local upperStates = self.characterUpperStateComponents.states

  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local localTransforms = self.parentConstraintComponents.localTransforms

  local targetXs = self.characterComponents.targetXs
  local targetYs = self.characterComponents.targetYs

  local headYs = self.characterComponents.headYs

  local shoulderWidths = self.characterComponents.shoulderWidths
  local shoulderYs = self.characterComponents.shoulderYs

  local armLengths = self.characterComponents.armLengths

  local hipWidths = self.characterComponents.hipWidths
  local hipYs = self.characterComponents.hipYs

  local legLengths = self.characterComponents.legLengths

  for footId in pairs(self.footEntities) do
    local lowerLegId = self.game.entityParents[footId]
    local upperLegId = self.game.entityParents[lowerLegId]
    local characterId = self.game.entityParents[upperLegId]
    local directionX = directionXs[characterId]
    local side = self.leftEntities[upperLegId] and -1 or 1

    local contact = self.raySensorComponents.contacts[characterId]
    local characterBody = self.physicsDomain.bodies[characterId]
    local hipX, hipY = characterBody:getWorldPoint(-side * 0.5 * hipWidths[characterId], hipYs[characterId])

    local groundX, groundY, groundNormalX, groundNormalY

    if contact then
      groundX = contact.x
      groundY = contact.y

      groundNormalX = contact.normalX
      groundNormalY = contact.normalY
    else
      groundX, groundY = characterBody:getWorldPoint(0, 1.125)

      if inputYs[characterId] == 1 then
        groundX, groundY = characterBody:getWorldPoint(0, 0.875)
      end

      groundNormalX, groundNormalY = characterBody:getWorldVector(0, -1)
    end

    local groundTangentX = groundNormalY
    local groundTangentY = -groundNormalX

    if lowerStates[characterId] == "crouching" or lowerStates[characterId] == "falling" or lowerStates[characterId] == "standing" then
      footX = groundX + (directionX * 0.075 + side * 0.375) * groundTangentX
      footY = groundY + (directionX * 0.075 + side * 0.375) * groundTangentY
    else
      local angle

      if lowerStates[characterId] == "running" then
        angle = inputXs[characterId] * 12 * fixedTime + side * 0.5 * math.pi
      else
        if inputYs[characterId] == 1 then
          angle = inputXs[characterId] * 8 * fixedTime + side * 0.5 * math.pi
        else
          angle = inputXs[characterId] * 10 * fixedTime + side * 0.5 * math.pi
        end
      end

      footX = groundX + (directionX * 0.1 + 0.5 * math.cos(angle)) * groundTangentX + groundNormalX * 0.25 * math.max(0, 0.5 + math.sin(angle))
      footY = groundY + (directionX * 0.1 + 0.5 * math.cos(angle)) * groundTangentY + groundNormalY * 0.25 * math.max(0, 0.5 + math.sin(angle))
    end

    local legLength = legLengths[characterId]
    local kneeX, kneeY, footX, footY = inverseKinematics.solve(hipX, hipY, footX, footY, directionX * legLength)

    local distance = heart.math.distance2(hipX, hipY, footX, footY)
    local legAngle = math.atan2(footY - hipY, footX - hipX) - directionX * 0.5 * math.pi

    local kneeAngle = math.acos(directionX * math.min(distance / legLength, 1))
    local footAngle = math.atan2(groundNormalY, groundNormalX) + 0.5 * math.pi

    local z = -directionX * side * 0.1

    -- TODO: Find a better way to keep the z-coordinate
    local zTransform = love.math.newTransform():setMatrix(
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, z,
        0, 0, 0, 1)

    transforms[upperLegId]:setTransformation(hipX, hipY, legAngle - kneeAngle, directionX, 1):apply(zTransform)
    transforms[lowerLegId]:setTransformation(kneeX, kneeY, legAngle + kneeAngle, directionX, 1):apply(zTransform)
    transforms[footId]:setTransformation(footX, footY, footAngle, directionX, 1):apply(zTransform)
  end

  for id in pairs(self.characterEntities) do
    for _, headId in ipairs(self.game:findDescendantComponents(id, "head")) do
      local localTargetX, localTargetY = bodies[id]:getLocalPoint(targetXs[id], targetYs[id])

      local headAngle = 0.5 * heart.math.clamp(
        math.atan2(localTargetY, directionXs[id] * localTargetX), -0.5 * math.pi, 0.5 * math.pi)

      localTransforms[headId]:setTransformation(0, headYs[id], headAngle, 1 / 32, 1 / 32, 10, 8)

      -- TODO: Find a better way to keep the z-coordinate
      localTransforms[headId]:apply(love.math.newTransform():setMatrix(
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, -0.1,
        0, 0, 0, 1))
    end
  end

  for handId in pairs(self.handEntities) do
    local lowerArmId = self.game.entityParents[handId]
    local upperArmId = self.game.entityParents[lowerArmId]
    local characterId = self.game.entityParents[upperArmId]
    local directionX = directionXs[characterId]
    local side = self.leftEntities[upperArmId] and -1 or 1

    local characterBody = self.physicsDomain.bodies[characterId]

    local shoulderX, shoulderY = characterBody:getWorldPoint(
      -side * 0.5 * shoulderWidths[characterId], shoulderYs[characterId])

    local headX, headY = characterBody:getWorldPoint(0, -0.55)

    if upperStates[characterId] == "vaulting" then
      local handX, handY = characterBody:getWorldPoint(0, -1)
      local handAngle = math.atan2(handY - shoulderY, handX - shoulderX)

      local armLength = armLengths[characterId]
      local elbowX, elbowY, handX, handY = inverseKinematics.solve(shoulderX, shoulderY, handX, handY, -directionX * armLength)

      local distance = heart.math.distance2(shoulderX, shoulderY, handX, handY)
      local armAngle = math.atan2(handY - shoulderY, handX - shoulderX) - directionX * 0.5 * math.pi

      local elbowAngle = math.acos(directionX * math.min(distance / armLength, 1))

      local z = -directionX * side * 0.2

      -- TODO: Find a better way to keep the z-coordinate
      local zTransform = love.math.newTransform():setMatrix(
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, z,
          0, 0, 0, 1)

      transforms[upperArmId]:setTransformation(shoulderX, shoulderY, armAngle + elbowAngle, directionX, 1):apply(zTransform)
      transforms[lowerArmId]:setTransformation(elbowX, elbowY, armAngle - elbowAngle, directionX, 1):apply(zTransform)
      transforms[handId]:setTransformation(handX, handY, handAngle, directionX, 1):apply(zTransform)
    else
      local handX = targetXs[characterId]
      local handY = targetYs[characterId]
      local handAngle = math.atan2(handY - shoulderY, handX - shoulderX)

      local armLength = armLengths[characterId]
      local elbowX, elbowY, handX, handY = inverseKinematics.solve(shoulderX, shoulderY, handX, handY, -directionX * armLength)

      local distance = heart.math.distance2(shoulderX, shoulderY, handX, handY)
      local armAngle = math.atan2(handY - shoulderY, handX - shoulderX) - directionX * 0.5 * math.pi

      local elbowAngle = math.acos(directionX * math.min(distance / armLength, 1))

      local z = -directionX * side * 0.2

      -- TODO: Find a better way to keep the z-coordinate
      local zTransform = love.math.newTransform():setMatrix(
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, z,
          0, 0, 0, 1)

      transforms[upperArmId]:setTransformation(shoulderX, shoulderY, armAngle + elbowAngle, directionX, 1):apply(zTransform)
      transforms[lowerArmId]:setTransformation(elbowX, elbowY, armAngle - elbowAngle, directionX, 1):apply(zTransform)
      transforms[handId]:setTransformation(handX, handY, handAngle, directionX, 1):apply(zTransform)
    end
  end
end

return M
