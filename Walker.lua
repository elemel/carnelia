local class = require("class")

local M = class.new()

function M:init(parent, config)
  self.parent = assert(parent)
  self.game = assert(self.parent.game)

  local x = config.x or 0
  local y = config.y or 0

  local world = self.game.physicsDomain.world

  self.trunkBody = love.physics.newBody(world, x, y, "dynamic")
  self.trunkBody:setFixedRotation(true)

  local wheelDistance = config.wheelDistance or 0.8
  self.wheelBody = love.physics.newBody(world, x, y + wheelDistance, "dynamic")

  local trunkShape = love.physics.newCircleShape(config.trunkRadius or 0.5)

  self.trunkFixture = love.physics.newFixture(
    self.trunkBody, trunkShape, config.trunkDensity or 1)

  local wheelSize = 2 * (config.wheelRadius or 0.3)
  local wheelShape = love.physics.newRectangleShape(wheelSize, wheelSize)

  self.wheelFixture = love.physics.newFixture(
    self.wheelBody, wheelShape, config.wheelDensity or 1)

  self.wheelFixture:setFriction(config.wheelFriction or 5)

  self.wheelJoint = love.physics.newWheelJoint(
    self.trunkBody, self.wheelBody, x, y + wheelDistance, 0, 1)

  self.wheelJoint:setSpringFrequency(config.springFrequency or 5)
  self.wheelJoint:setSpringDampingRatio(config.springDampingRatio or 1)

  self.wheelJoint:setMotorEnabled(true)
  self.wheelJoint:setMaxMotorTorque(config.maxMotorTorque or 30)
end

function M:destroy()
  self.wheelJoint:destroy()
  self.wheelJoint = nil

  self.wheelFixture:destroy()
  self.wheelFixture = nil

  self.trunkFixture:destroy()
  self.trunkFixture = nil

  self.wheelBody:destroy()
  self.wheelBody = nil

  self.trunkBody:destroy()
  self.trunkBody = nil
end

return M
