local class = require("class")
local GroundSensor = require("GroundSensor")
local Plant = require("Plant")
local Sprite = require("Sprite")
local Walker = require("Walker")

local M = class.new()

local function setLinearVelocityY(body, velocityY)
  local oldVelocityX, oldVelocityY = body:getLinearVelocity()
  body:setLinearVelocity(oldVelocityX, velocityY)
end

function M:init(game, config)
  self.game = assert(game)

  local x = config.x or 0
  local y = config.y or 0

  self.body = love.physics.newBody(self.game.physicsDomain.world, x, y, "dynamic")
  self.body:setFixedRotation(true)

  local shape = love.physics.newCircleShape(0.5)
  self.fixture = love.physics.newFixture(self.body, shape)

  self.walker = Walker.new(self, {})

  self.image = love.graphics.newImage("resources/images/skins/plant-farmer/trunk.png")
  local scale = 0.02
  local width, height = self.image:getDimensions()
  self.sprite = Sprite.new(self.game, self.image, love.math.newTransform(0, 0, 0, scale, scale, 0.5 * width, 0.5 * height))

  self.directionX = 1
  self.inputY = 0
  self.jumpInput = false

  self.game.inputDomain.fixedUpdateHandlers[self] = self.fixedUpdateInput
  self.game.animationDomain.updateHandlers[self] = self.updateAnimation

  self.groundSensor = GroundSensor.new(self, {})
  self.plant = Plant.new(self, {})
end

function M:destroy()
  self.groundSensor:destroy()
  self.plant:destroy()

  self.game.animationDomain.updateHandlers[self] = nil
  self.game.inputDomain.fixedUpdateHandlers[self] = nil

  self.sprite:destroy()
  self.walker:destroy()

  self.fixture:destroy()
  self.body:destroy()
end

function M:fixedUpdateInput(dt)
  local left = love.keyboard.isDown("a")
  local right = love.keyboard.isDown("d")

  local up = love.keyboard.isDown("w")
  local down = love.keyboard.isDown("s")

  local inputX = (right and 1 or 0) - (left and 1 or 0)
  local inputY = (down and 1 or 0) - (up and 1 or 0)

  self.walker.joint:setMotorEnabled(inputX ~= 0)
  local speed = 8

  if inputY == 1 or inputX * self.directionX < 0 then
    speed = 5
  end

  if inputY == -1 and inputX * self.directionX > 0 then
    speed = 13
  end

  self.walker.joint:setMotorSpeed(speed * inputX)

  if inputY ~= self.inputY then
    if inputY == 1 and self.inputY ~= 1 then
      self.walker.distance = 0.5
      self.walker:updateJoint()
    elseif inputY ~= 1 and self.inputY == 1 then
      self.walker.distance = 0.8
      self.walker:updateJoint()
    end

    self.inputY = inputY
  end

  local jumpInput = love.keyboard.isDown("space")

  if jumpInput and not self.jumpInput and self.groundSensor.fixture then
    local velocityY = self.groundSensor.linearVelocityY - 13

    setLinearVelocityY(self.body, velocityY)
    setLinearVelocityY(self.walker.body, velocityY)
    setLinearVelocityY(self.plant.body, velocityY)
  end

  self.jumpInput = jumpInput
end

function M:updateAnimation(dt)
  local x, y = self.body:getPosition()
  local scale = 0.02
  local width, height = self.image:getDimensions()
  self.sprite.transform:setTransformation(x, y, 0, self.directionX * scale, scale, 0.5 * width, 0.5 * height)
end

return M
