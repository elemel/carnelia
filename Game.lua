local Camera = require("Camera")
local class = require("class")
local PhysicsDomain = require("PhysicsDomain")

local Game = class.new()

function Game:init()
  self.fixedDt = 1 / 60
  self.accumulatedDt = 0

  local viewportWidth, viewportHeight = love.graphics.getDimensions()

  self.camera = Camera.new({
    viewportWidth = viewportWidth,
    viewportHeight = viewportHeight,
  })

  self.physicsDomain = PhysicsDomain.new(self, {})
end

function Game:update(dt)
  self.accumulatedDt = self.accumulatedDt + dt

  while self.accumulatedDt >= self.fixedDt do
    self.accumulatedDt = self.accumulatedDt - self.fixedDt
    self:fixedUpdate(self.fixedDt)
  end
end

function Game:fixedUpdate(dt)
  self.physicsDomain:fixedUpdate(dt)
end

function Game:draw()
  self.camera:applyTransform()
  love.graphics.circle("line", 0, 0, 0.5, 256)
  self.physicsDomain:debugDraw()
end

return Game
