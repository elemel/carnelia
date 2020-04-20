local AnimationDomain = require("AnimationDomain")
local Camera = require("Camera")
local class = require("class")
local ControlDomain = require("ControlDomain")
local GraphicsDomain = require("GraphicsDomain")
local InputDomain = require("InputDomain")
local PhysicsDomain = require("PhysicsDomain")

local M = class.new()

function M:init()
  self.fixedDt = 1 / 60
  self.accumulatedDt = 0
  self.fixedTime = 0

  local viewportWidth, viewportHeight = love.graphics.getDimensions()

  self.camera = Camera.new({
    scale = 0.1,
    viewportWidth = viewportWidth,
    viewportHeight = viewportHeight,
  })

  self.inputDomain = InputDomain.new(self, {})
  self.ControlDomain = ControlDomain.new(self, {})
  self.physicsDomain = PhysicsDomain.new(self, {})
  self.animationDomain = AnimationDomain.new(self, {})
  self.graphicsDomain = GraphicsDomain.new(self, {})

  self.groundBody = love.physics.newBody(self.physicsDomain.world, 0, 1, "kinematic")

  local groundShape = love.physics.newRectangleShape(10, 0.5)
  local groundFixture = love.physics.newFixture(self.groundBody, groundShape)

  self.debugDrawHandlers = {}
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
  self.fixedTime = self.fixedTime + dt
  self.inputDomain:fixedUpdate(dt)

  local targetAngle = 0.125 * math.pi * math.sin(self.fixedTime)
  local currentAngle = self.groundBody:getAngle()
  self.groundBody:setAngularVelocity((targetAngle - currentAngle) / dt)

  self.physicsDomain:fixedUpdate(dt)
end

function M:draw()
  self.camera:applyTransform()
  self.graphicsDomain:draw()
  self.physicsDomain:debugDraw()

  for key, handler in pairs(self.debugDrawHandlers) do
    handler(key)
  end
end

function M:resize(width, height)
  self.camera.viewportWidth = width
  self.camera.viewportHeight = height
  self.camera:updateTransform()
end

function M:mousemoved(x, y, dx, dy, istouch)
  self.inputDomain:mousemoved(x, y, dx, dy, istouch)
end

return M
