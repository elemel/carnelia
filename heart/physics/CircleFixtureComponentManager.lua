local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.boneComponents = assert(self.game.componentManagers.bone)
end

function M:createComponent(entityId, config)
  local transform = self.boneComponents.transforms[entityId]
  local bodyId = assert(self.game:findAncestorComponent(entityId, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local x = config.x or 0
  local y = config.y or 0
  x, y = transform:transformPoint(x, y)
  x, y = body:getLocalPoint(x, y)
  local radius = config.radius or 0.5
  radius = heartMath.transformRadius(transform, radius)
  local shape = love.physics.newCircleShape(x, y, radius)
  local density = config.density or 1
  local fixture = love.physics.newFixture(body, shape, density)
  fixture:setUserData(entityId)
  fixture:setFriction(config.friction or 0.2)
  fixture:setRestitution(config.restitution or 0)
  fixture:setGroupIndex(config.groupIndex or 0)
  fixture:setSensor(config.sensor or false)
  self.physicsDomain.circleFixtures[entityId] = fixture
  return fixture
end

function M:destroyComponent(entityId)
  self.physicsDomain.circleFixtures[entityId]:destroy()
  self.physicsDomain.circleFixtures[entityId] = nil
end

return M
