local class = require("class")

local M = class.new()

function M:init(parent, config)
  self.parent = assert(parent)
  self.game = assert(self.parent.game)

  local x, y = self.parent.body:getPosition()
  local distance = config.distance or 0.8

  self.body = love.physics.newBody(
    self.game.physicsDomain.world, x, y + distance, "dynamic")

  local size = config.size or 0.6
  local shape = love.physics.newRectangleShape(size, size)

  self.fixture = love.physics.newFixture(
    self.body, shape, config.density or 1)

  self.fixture:setFriction(config.friction or 5)

  self.joint = love.physics.newWheelJoint(
    self.parent.body, self.body, x, y + distance, 0, 1)

  self.joint:setSpringFrequency(config.springFrequency or 5)
  self.joint:setSpringDampingRatio(config.springDampingRatio or 1)

  self.joint:setMotorEnabled(true)
  self.joint:setMaxMotorTorque(config.maxMotorTorque or 30)
end

function M:destroy()
  self.joint:destroy()
  self.fixture:destroy()
  self.body:destroy()
end

return M
