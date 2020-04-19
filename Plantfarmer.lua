local class = require("class")
local Sprite = require("Sprite")
local Walker = require("Walker")

local M = class.new()

function M:init(game, config)
  self.game = assert(game)

  self.walker = Walker.new(self.game, {
    x = config.x,
    y = config.y,
  })

  self.image = love.graphics.newImage("resources/images/skins/plant-farmer/trunk.png")
  local scale = 0.02
  local width, height = self.image:getDimensions()
  self.sprite = Sprite.new(self.game, self.image, love.math.newTransform(0, 0, 0, scale, scale, 0.5 * width, 0.5 * height))

  self.game.inputDomain.handlers[self] = self.fixedUpdateInput
  self.game.animationDomain.handlers[self] = self.updateAnimation
end

function M:destroy()
  self.game.animationDomain.handlers[self] = nil
  self.game.inputDomain.handlers[self] = nil
  self.sprite:destroy()
  self.walker:destroy()
end

function M:fixedUpdateInput(dt)
  local left = love.keyboard.isDown("a")
  local right = love.keyboard.isDown("d")

  local inputX = (right and 1 or 0) - (left and 1 or 0)

  self.walker.wheelJoint:setMotorEnabled(inputX ~= 0)
  self.walker.wheelJoint:setMotorSpeed(5 * inputX)
end

function M:updateAnimation(dt)
  local x, y = self.walker.trunkBody:getPosition()
  local scale = 0.02
  local width, height = self.image:getDimensions()
  self.sprite.transform:setTransformation(x, y, 0, scale, scale, 0.5 * width, 0.5 * height)
end

return M
