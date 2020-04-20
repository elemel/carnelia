local class = require("class")
local Sprite = require("Sprite")
local utils = require("utils")

local M = class.new()

function M:init(parent, config)
  self.parent = assert(parent)
  self.game = assert(parent.game)

  local parentX, parentY = self.parent.body:getPosition()

  local x = parentX
  local y = parentY - 1.5

  self.body = love.physics.newBody(
    self.game.physicsDomain.world, x, y, "dynamic")

  local shape = love.physics.newCircleShape(0.3)
  self.fixture = love.physics.newFixture(self.body, shape, 0.1)
  self.fixture:setSensor(true)

  self.motorJoint = love.physics.newMotorJoint(self.parent.body, self.body)
  self.motorJoint:setLinearOffset(0, -1.5)
  self.motorJoint:setMaxForce(10)

  local ropeX1, ropeY1 = self.parent.body:getWorldPoint(0, -0.75)
  local ropeX2, ropeY2 = self.parent.body:getWorldPoint(0, -1.5)

  self.ropeJoint = love.physics.newRopeJoint(
    self.parent.body, self.body, ropeX1, ropeY1, ropeX2, ropeY2, 3)

  self.image = love.graphics.newImage("resources/images/plant.png")
  local scale = 0.02
  local width, height = self.image:getDimensions()

  local transform = love.math.newTransform(
    x, y, 0, scale, scale, 0.5 * width, 0.5 * height)

  self.sprite = Sprite.new(self.game, self.image, transform, 0.1)

  self.curve = love.math.newBezierCurve(
    ropeX1, ropeY1, ropeX1, ropeY1, ropeX2, ropeY2, ropeX2, ropeY2)

  self.game.inputDomain.fixedUpdateHandlers[self] = self.fixedUpdateInput
  self.game.animationDomain.updateHandlers[self] = self.updateAnimation
  self.game.debugDrawHandlers[self] = self.debugDraw
end

function M:destroy()
  self.game.debugDrawHandlers[self] = nil
  self.game.animationDomain.updateHandlers[self] = nil
  self.game.inputDomain.fixedUpdateHandlers[self] = nil

  self.sprite:destroy()

  self.ropeJoint:destroy()
  self.ropeJoint = nil

  self.motorJoint:destroy()
  self.motorJoint = nil

  self.fixture:destroy()
  self.fixture = nil

  self.body:destroy()
  self.body = nil
end

function M:fixedUpdateInput(dt)
  local offsetX, offsetY = self.motorJoint:getLinearOffset()
  local sensitivity = 0.01
  local dx, dy = self.game.inputDomain:readMouseMovement()

  offsetX = offsetX + sensitivity * dx
  offsetY = offsetY + sensitivity * dy

  local bodyA, bodyB = self.ropeJoint:getBodies()
  local x1, y1, x2, y2 = self.ropeJoint:getAnchors()
  local localX1, localY1 = bodyA:getLocalPoint(x1, y1)

  local distance = utils.distance(localX1, localY1, offsetX, offsetY)
  local maxLength = self.ropeJoint:getMaxLength()

  if distance > maxLength then
    offsetX = offsetX - localX1
    offsetY = offsetY - localY1

    offsetX = offsetX * maxLength / distance
    offsetY = offsetY * maxLength / distance

    offsetX = offsetX + localX1
    offsetY = offsetY + localY1
  end

  self.motorJoint:setLinearOffset(offsetX, offsetY)

  if offsetX * self.parent.directionX < 0 then
    self.parent.directionX = -self.parent.directionX
  end
end

function M:updateAnimation(dt)
  local x, y = self.body:getPosition()
  local scale = 0.02
  local directionX = self.parent.directionX
  local width, height = self.image:getDimensions()
  self.sprite.transform:setTransformation(x, y, 0, directionX * scale, scale, 0.5 * width, 0.5 * height)
end


function M:debugDraw()
  love.graphics.setColor(0, 1, 0, 1)
  local bodyA, bodyB = self.ropeJoint:getBodies()
  local x1, y1, x2, y2 = self.ropeJoint:getAnchors()

  local directionX = self.parent.directionX

  self.curve:setControlPoint(1, x1 - directionX * 0.5, y1 + 0.25)
  self.curve:setControlPoint(2, x1 - directionX * 0.5, y1 + 0.25 - 1.5)
  self.curve:setControlPoint(3, x2 - directionX * (0.3 + 1.5), y2)
  self.curve:setControlPoint(4, x2 - directionX * 0.3, y2)

  love.graphics.line(self.curve:render())
  love.graphics.setColor(1, 1, 1, 1)
end

return M
