local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.inputDomain = assert(self.game.domains.input)
  self.physicsDomain = assert(self.game.domains.physics)

  self.plantEntities = assert(self.game.componentEntitySets.plant)

  self.transformComponents =
    assert(self.game.componentManagers.transform)


  self.parentConstraintComponents =
    assert(self.game.componentManagers.parentConstraint)

  self.mouseDown = love.mouse.isDown()
end

function M:__call(dt)
  local transforms = self.transformComponents.transforms
  local localTransforms = self.parentConstraintComponents.localTransforms
  local enabledFlags = self.parentConstraintComponents.enabledFlags
  local ropeJoints = self.physicsDomain.ropeJoints
  local bodies = self.physicsDomain.bodies

  local dx = self.inputDomain.accumulatedMouseDx
  local dy = self.inputDomain.accumulatedMouseDy

  self.inputDomain.accumulatedMouseDx = 0
  self.inputDomain.accumulatedMouseDy = 0

  local sensitivity = 0.01
  local mouseDown = love.mouse.isDown(1)

  for id in pairs(self.plantEntities) do
    if mouseDown then
      if not self.mouseDown then
        local localTransform = localTransforms[id]
        local x, y = localTransform:transformPoint(0, 0)

        local parentId = self.game.entityParents[id]
        local parentBody = bodies[parentId]

        local x1, y1 = parentBody:getPosition()
        local x2, y2 = parentBody:getWorldPoint(x, y)

        local hitFixture, hitX, hitY

        local function callback(fixture, x, y, xn, yn, fraction)
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
          local ropeX2, ropeY2 = transforms[id]:inverseTransformPoint(x1, y1)
          local maxLength = heart.math.distance2(hitX, hitY, x1, y1)

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
        end
      end
    else
      if ropeJoints[id] then
        self.game:destroyComponent(id, "ropeJoint")
      end
    end

    if ropeJoints[id] then
    else
      local localTransform = localTransforms[id]
      local x, y = localTransform:transformPoint(0, 0)

      x = x + sensitivity * dx
      y = y + sensitivity * dy

      x, y = heart.math.clampLength2(x, y, 0, 5)

      local angle = math.atan2(y, x)

      localTransform:setTransformation(x, y, angle)
      enabledFlags[id] = true
    end
  end

  self.mouseDown = mouseDown
end

return M
