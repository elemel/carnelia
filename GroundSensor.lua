local class = require("class")

local M = class.new()

function M:init(parent, config)
  self.parent = assert(parent)
  self.game = assert(parent.game)

  self.range = config.range or 1.25

  self.x = 0
  self.y = 0

  self.normalX = 0
  self.normalY = -1

  self.linearVelocityX = 0
  self.linearVelocityY = 0

  self.angularVelocity = 0

  self.game.collisionDomain.fixedUpdateHandlers[self] =
    self.fixedUpdateCollision

  self.game.debugDrawHandlers[self] = self.debugDraw
end

function M:destroy()
  self.game.debugDrawHandlers[self] = nil
  self.game.collisionDomain.fixedUpdateHandlers[self] = nil
end

function M:fixedUpdateCollision(dt)
  local x1, y1 = self.parent.body:getPosition()

  local x2 = x1
  local y2 = y1 + self.range

  self.fixture = nil

  local function callback(fixture, x, y, xn, yn, fraction)
    if not fixture:isSensor() and fixture:getBody():getType() ~= "dynamic" then
      self.fixture = fixture

      self.x = x
      self.y = y

      self.normalX = xn
      self.normalY = yn

      return fraction
    end

    return 1
  end

  self.game.physicsDomain.world:rayCast(x1, y1, x2, y2, callback)

  if self.fixture then
    self.linearVelocityX, self.linearVelocityY =
      self.fixture:getBody():getLinearVelocityFromWorldPoint(
        self.x, self.y)

    self.angularVelocity = self.fixture:getBody():getAngularVelocity()
  end
end

function M:debugDraw()
  love.graphics.setColor(0, 1, 0, 1)

  local x, y = self.parent.body:getPosition()
  love.graphics.line(x, y, x, y + self.range)

  if self.fixture then
    love.graphics.line(
      self.x, self.y,
      self.x + self.normalX, self.y + self.normalY)
  end

  love.graphics.setColor(1, 1, 1, 1)
end

return M
