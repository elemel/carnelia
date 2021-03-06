local class = require("heart.class")
local physics = require("heart.physics")
local getLocalPoints = physics.getLocalPoints
local heartMath = require("heart.math")
local transformPoints2 = heartMath.transformPoints2

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.boneComponents = assert(self.game.componentManagers.bone)
end

function M:createComponent(id, config)
  local transform = self.boneComponents.transforms[id]

  local bodyId = assert(self.game:findAncestorComponent(id, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local points = transformPoints2(transform, config.points)
  points = getLocalPoints(body, points)
  local shape = love.physics.newPolygonShape(points)
  local density = config.density or 1
  local fixture = love.physics.newFixture(body, shape, density)
  fixture:setUserData(id)
  fixture:setFriction(config.friction or 0.2)
  fixture:setRestitution(config.restitution or 0)
  fixture:setGroupIndex(config.groupIndex or 0)
  fixture:setSensor(config.sensor or false)
  self.physicsDomain.polygonFixtures[id] = fixture
  return fixture
end

function M:destroyComponent(id)
  self.physicsDomain.polygonFixtures[id]:destroy()
  self.physicsDomain.polygonFixtures[id] = nil
end

return M
