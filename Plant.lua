local class = require("class")
local Sprite = require("Sprite")

local M = class.new()

function M:init(parent, config)
  self.parent = assert(parent)
  self.game = assert(parent.game)
  local world = self.game.physicsDomain.world
  local parentBody = self.parent.walker.trunkBody
  local parentX, parentY = parentBody:getPosition()

  local x = parentX
  local y = parentY - 1.5

  self.body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newCircleShape(0.25)
  self.fixture = love.physics.newFixture(self.body, shape, 0.5)
  self.joint = love.physics.newMotorJoint(parentBody, self.body)
  self.joint:setLinearOffset(0, -1.5)
  self.joint:setMaxForce(20)

  self.image = love.graphics.newImage("resources/images/plant.png")
  local scale = 0.02
  local width, height = self.image:getDimensions()

  self.sprite = Sprite.new(
    self.game, self.image, love.math.newTransform(
      x, y, 0, scale, scale, 0.5 * width, 0.5 * height))

  self.game.inputDomain.fixedUpdateHandlers[self] = self.fixedUpdateInput
  self.game.animationDomain.updateHandlers[self] = self.updateAnimation
end

function M:destroy()
  self.game.animationDomain.updateHandlers[self] = nil
  self.game.inputDomain.fixedUpdateHandlers[self] = nil

  self.sprite:destroy()

  self.joint:destroy()
  self.joint = nil

  self.fixture:destroy()
  self.fixture = nil

  self.body:destroy()
  self.body = nil
end

function M:fixedUpdateInput(dt)
end

function M:updateAnimation(dt)
  local x, y = self.body:getPosition()
  local scale = 0.02
  local width, height = self.image:getDimensions()
  self.sprite.transform:setTransformation(x, y, 0, scale, scale, 0.5 * width, 0.5 * height)
end

return M
