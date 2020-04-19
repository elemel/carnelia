local AnimationDomain = require("AnimationDomain")
local Camera = require("Camera")
local class = require("class")
local GraphicsDomain = require("GraphicsDomain")
local InputDomain = require("InputDomain")
local PhysicsDomain = require("PhysicsDomain")

local M = class.new()

function M:init()
  self.fixedDt = 1 / 60
  self.accumulatedDt = 0

  local viewportWidth, viewportHeight = love.graphics.getDimensions()

  self.camera = Camera.new({
    scale = 0.1,
    viewportWidth = viewportWidth,
    viewportHeight = viewportHeight,
  })

  self.inputDomain = InputDomain.new(self, {})
  self.physicsDomain = PhysicsDomain.new(self, {})
  self.animationDomain = AnimationDomain.new(self, {})
  self.graphicsDomain = GraphicsDomain.new(self, {})

  local groundBody = love.physics.newBody(self.physicsDomain.world, 0, 1, "static")
  groundBody:setAngle(-0.1 * math.pi)

  local groundShape = love.physics.newRectangleShape(10, 0.5)
  local groundFixture = love.physics.newFixture(groundBody, groundShape)
end

function M:update(dt)
  self.accumulatedDt = self.accumulatedDt + dt

  while self.accumulatedDt >= self.fixedDt do
    self.accumulatedDt = self.accumulatedDt - self.fixedDt
    self:fixedUpdate(self.fixedDt)
  end

  self.animationDomain:update(dt)
end

function M:fixedUpdate(dt)
  self.inputDomain:fixedUpdate(dt)
  self.physicsDomain:fixedUpdate(dt)
end

function M:draw()
  self.camera:applyTransform()
  self.graphicsDomain:draw()
  self.physicsDomain:debugDraw()
end

function M:resize(width, height)
  self.camera.viewportWidth = width
  self.camera.viewportHeight = height
  self.camera:updateTransform()
end

return M
