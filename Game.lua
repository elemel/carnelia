local Camera = require("Camera")
local class = require("class")
local PhysicsDomain = require("PhysicsDomain")

local Game = class.new()

function Game:init()
  self.fixedDt = 1 / 60
  self.accumulatedDt = 0

  local viewportWidth, viewportHeight = love.graphics.getDimensions()

  self.camera = Camera.new({
    scale = 0.1,
    viewportWidth = viewportWidth,
    viewportHeight = viewportHeight,
  })

  self.physicsDomain = PhysicsDomain.new(self, {})

  local groundBody = love.physics.newBody(self.physicsDomain.world, 0, 0, "static")
  local groundShape = love.physics.newRectangleShape(10, 1)
  local groundFixture = love.physics.newFixture(groundBody, groundShape)
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
  self.physicsDomain:debugDraw()
end

function Game:resize(width, height)
  self.camera.viewportWidth = width
  self.camera.viewportHeight = height
  self.camera:updateTransform()
end

return Game
