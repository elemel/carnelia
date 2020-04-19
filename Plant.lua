local class = require("class")

local M = class.new()

function M:init(parent, config)
  self.parent = assert(parent)
  self.game = assert(parent.game)
  local world = self.game.physicsDomain.world
  local parentBody = self.parent.walker.trunkBody
  local parentX, parentY = parentBody:getPosition()
  self.body = love.physics.newBody(world, parentX, parentY - 1.5, "dynamic")
  local shape = love.physics.newCircleShape(0.25)
  self.fixture = love.physics.newFixture(self.body, shape)
  self.joint = love.physics.newMotorJoint(parentBody, self.body)
  self.joint:setLinearOffset(0, -1.5)
  self.joint:setMaxForce(20)
end

function M:destroy()
  self.joint:destroy()
  self.joint = nil

  self.fixture:destroy()
  self.fixture = nil

  self.body:destroy()
  self.body = nil
end

return M
