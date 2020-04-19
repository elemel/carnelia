local class = require("class")
local Sprite = require("Sprite")
local utils = require("utils")

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

  local shape = love.physics.newCircleShape(0.375)
  self.fixture = love.physics.newFixture(self.body, shape, 0.1)
  self.fixture:setSensor(true)

  self.joint = love.physics.newMotorJoint(parentBody, self.body)
  self.joint:setLinearOffset(0, -1.5)
  self.joint:setMaxForce(20)

  self.anchorX = 0
  self.anchorY = -0.75

  self.image = love.graphics.newImage("resources/images/plant.png")
  local scale = 0.02
  local width, height = self.image:getDimensions()

  local transform = love.math.newTransform(
    x, y, 0, scale, scale, 0.5 * width, 0.5 * height)

  self.sprite = Sprite.new(self.game, self.image, transform, 0.1)

  self.length = 3

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
  local offsetX, offsetY = self.joint:getLinearOffset()
  local sensitivity = 0.01
  local dx, dy = self.game.inputDomain:readMouseMovement()

  offsetX = offsetX + sensitivity * dx
  offsetY = offsetY + sensitivity * dy

  local distance = utils.distance(offsetX, offsetY, self.anchorX, self.anchorY)

  if distance > self.length then
    offsetX = offsetX - self.anchorX
    offsetY = offsetY - self.anchorY

    offsetX = offsetX * self.length / distance
    offsetY = offsetY * self.length / distance

    offsetX = offsetX + self.anchorX
    offsetY = offsetY + self.anchorY
  end

  self.joint:setLinearOffset(offsetX, offsetY)
end

function M:updateAnimation(dt)
  local x, y = self.body:getPosition()
  local scale = 0.02
  local width, height = self.image:getDimensions()
  self.sprite.transform:setTransformation(x, y, 0, scale, scale, 0.5 * width, 0.5 * height)
end

return M
