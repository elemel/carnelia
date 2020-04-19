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

  local image = love.graphics.newImage("resources/images/skins/plantfarmer/trunk.png")
  local scale = 0.02
  local width, height = image:getDimensions()
  self.sprite = Sprite.new(self.game, image, love.math.newTransform(0, 0, 0, scale, scale, 0.5 * width, 0.5 * height))

  self.game.inputDomain.handlers[self] = self.fixedUpdateInput
end

function M:destroy()
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

return M
