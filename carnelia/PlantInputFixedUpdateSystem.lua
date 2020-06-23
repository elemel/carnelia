local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.inputDomain = assert(self.game.domains.input)
  self.physicsDomain = assert(self.game.domains.physics)

  self.plantEntities = assert(self.game.componentEntitySets.plant)
  self.characterComponents = assert(self.game.componentManagers.character)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.plantComponents = assert(self.game.componentManagers.plant)
  self.characterUpperStateComponents = assert(self.game.componentManagers.characterUpperState)

  self.mouseDown = love.mouse.isDown(1)
end

function M:handleEvent(dt)
  local transforms = self.boneComponents.transforms
  local distanceJoints = self.physicsDomain.distanceJoints
  local ropeJoints = self.physicsDomain.ropeJoints
  local bodies = self.physicsDomain.bodies
  local states = self.characterUpperStateComponents.states

  local localXs = self.plantComponents.localXs
  local localYs = self.plantComponents.localYs

  local localNormalXs = self.plantComponents.localNormalXs
  local localNormalYs = self.plantComponents.localNormalYs

  local dx = self.inputDomain.accumulatedMouseDx
  local dy = self.inputDomain.accumulatedMouseDy

  self.inputDomain.accumulatedMouseDx = 0
  self.inputDomain.accumulatedMouseDy = 0

  local sensitivity = 0.01
  local mouseDown = love.mouse.isDown(1)

  local targetXs = self.characterComponents.targetXs
  local targetYs = self.characterComponents.targetYs

  for id in pairs(self.plantEntities) do
    local parentId = self.game.entityParents[id]

    if mouseDown then
      if not self.mouseDown then
        local parentBody = bodies[parentId]

        local x1, y1 = parentBody:getPosition()

        local x2 = x1 + localXs[id]
        local y2 = y1 + localYs[id]

        local hitFixture, hitX, hitY, hitNormalX, hitNormalY

        local function callback(fixture, x, y, xn, yn, fraction)
          if fixture:isSensor() then
            return 1
          end

          local body = fixture:getBody()
          local bodyType = body:getType()

          if bodyType == "static" or bodyType == "kinematic" then
            hitFixture = fixture

            hitX = x
            hitY = y

            hitNormalX = xn
            hitNormalY = yn

            return fraction
          end

          return 1
        end

        self.physicsDomain.world:rayCast(x1, y1, x2, y2, callback)

        if hitFixture then
          if states[parentId] == "vaultAiming" then
            local ropeX1, ropeY1 = transforms[id]:inverseTransformPoint(hitX, hitY)
            local ropeX2, ropeY2 = transforms[id]:inverseTransformPoint(parentBody:getWorldPoint(0, -1.25))

            local maxLength = heart.math.distance2(hitX, hitY, x1, y1)

            -- self.game:createComponent(id, "ropeJoint", {
            --   body1 = hitFixture:getUserData(),
            --   body2 = parentId,

            --   x1 = ropeX1,
            --   y1 = ropeY1,

            --   x2 = ropeX2,
            --   y2 = ropeY2,

            --   maxLength = maxLength,
            --   collideConnected = true,
            -- })

            self.game:createComponent(id, "distanceJoint", {
              body1 = hitFixture:getUserData(),
              body2 = parentId,

              x1 = ropeX1,
              y1 = ropeY1,

              x2 = ropeX2,
              y2 = ropeY2,

              frequency = 1,
              dampingRatio = 0.1,

              collideConnected = true,
            })

            self.characterUpperStateComponents:setState(parentId, "vaulting")

            localNormalXs[id], localNormalYs[id] = hitFixture:getBody():getLocalVector(hitNormalX, hitNormalY)
          else
            local ropeX1, ropeY1 = transforms[id]:inverseTransformPoint(hitX, hitY)
            local ropeX2, ropeY2 = transforms[id]:inverseTransformPoint(parentBody:getWorldPoint(0, -0.3))

            local maxLength = heart.math.distance2(hitX, hitY, parentBody:getWorldPoint(0, -0.3))

            self.game:createComponent(id, "ropeJoint", {
              body1 = hitFixture:getUserData(),
              body2 = parentId,

              x1 = ropeX1,
              y1 = ropeY1,

              x2 = ropeX2,
              y2 = ropeY2,

              maxLength = maxLength,
              collideConnected = true,
            })

            self.characterUpperStateComponents:setState(parentId, "swinging")

            localNormalXs[id], localNormalYs[id] = hitFixture:getBody():getLocalVector(hitNormalX, hitNormalY)
          end
        end
      end
    else
      local joint = distanceJoints[id] or ropeJoints[id]

      if joint then
        local x1, y1, x2, y2 = joint:getAnchors()
        local x, y = bodies[parentId]:getPosition()

        localXs[id] = x1 - x
        localYs[id] = y1 - y

        self.game:destroyComponent(id, "distanceJoint")
        self.game:destroyComponent(id, "ropeJoint")

        if states[parentId] == "vaulting" then
          self.characterUpperStateComponents:setState(parentId, "vaultAiming")
        else
          self.characterUpperStateComponents:setState(parentId, "aiming")
        end
      end
    end

    local parentX, parentY = bodies[parentId]:getPosition()

    if states[parentId] == "vaulting" then
      local x1, y1, x2, y2 = distanceJoints[id]:getAnchors()

      localXs[id] = x1 - parentX
      localYs[id] = y1 - parentY
    elseif states[parentId] == "swinging" then
      local x1, y1, x2, y2 = ropeJoints[id]:getAnchors()

      localXs[id] = x1 - parentX
      localYs[id] = y1 - parentY
    else
      localXs[id] = localXs[id] + sensitivity * dx
      localYs[id] = localYs[id] + sensitivity * dy

      -- TODO: Do a proper transformation to account for rotation
      localYs[id] = localYs[id] + 0.55
      localXs[id], localYs[id] = heart.math.clampLength2(localXs[id], localYs[id], 0.5, 7.5)
      localYs[id] = localYs[id] - 0.55
    end

    targetXs[parentId] = parentX + localXs[id]
    targetYs[parentId] = parentY + localYs[id]

    local directionX = localXs[id] < 0 and -1 or 1
    self.characterComponents:setDirectionX(parentId, directionX)
  end

  self.mouseDown = mouseDown
end

return M
