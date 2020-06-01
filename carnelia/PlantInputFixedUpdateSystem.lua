local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.inputDomain = assert(self.game.domains.input)
  self.physicsDomain = assert(self.game.domains.physics)

  self.plantEntities = assert(self.game.componentEntitySets.plant)
  self.characterComponents = assert(self.game.componentManagers.character)

  self.plantComponents = assert(self.game.componentManagers.plant)

  self.transformComponents =
    assert(self.game.componentManagers.transform)

  self.mouseDown = love.mouse.isDown()
end

function M:handleEvent(dt)
  local transforms = self.transformComponents.transforms
  local distanceJoints = self.physicsDomain.distanceJoints
  local ropeJoints = self.physicsDomain.ropeJoints
  local bodies = self.physicsDomain.bodies

  local localXs = self.plantComponents.localXs
  local localYs = self.plantComponents.localYs

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

        local hitFixture, hitX, hitY

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

            return fraction
          end

          return 1
        end

        self.physicsDomain.world:rayCast(x1, y1, x2, y2, callback)

        if hitFixture then
          local ropeX1, ropeY1 = transforms[id]:inverseTransformPoint(hitX, hitY)
          local ropeX2, ropeY2 = transforms[id]:inverseTransformPoint(x1, y1 - 1.25)

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

          bodies[parentId]:setFixedRotation(false)
        end
      end
    else
      if distanceJoints[id] or ropeJoints[id] then
        local x1, y1, x2, y2 = distanceJoints[id]:getAnchors()
        local x, y = bodies[parentId]:getPosition()

        localXs[id] = x1 - x
        localYs[id] = y1 - y

        -- self.game:destroyComponent(id, "ropeJoint")
        self.game:destroyComponent(id, "distanceJoint")

        bodies[parentId]:setFixedRotation(true)
        bodies[parentId]:setAngle(0)
      end
    end

    local parentX, parentY = bodies[parentId]:getPosition()

    if distanceJoints[id] or ropeJoints[id] then
      local x1, y1, x2, y2 = distanceJoints[id]:getAnchors()

      localXs[id] = x1 - parentX
      localYs[id] = y1 - parentY
    else
      localXs[id] = localXs[id] + sensitivity * dx
      localYs[id] = localYs[id] + sensitivity * dy

      localXs[id], localYs[id] = heart.math.clampLength2(localXs[id], localYs[id], 0, 7.5)
    end

    targetXs[parentId] = parentX + localXs[id]
    targetYs[parentId] = parentY + localYs[id]

    local directionX = localXs[id] < 0 and -1 or 1
    self.characterComponents:setDirectionX(parentId, directionX)
  end

  self.mouseDown = mouseDown
end

return M
