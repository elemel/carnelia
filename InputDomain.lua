local class = require("class")

local M = class.new()

function M:init(game, config)
  self.accumulatedMouseDx = 0
  self.accumulatedMouseDy = 0

  self.fixedUpdateHandlers = {}
end

function M:fixedUpdate(dt)
  for key, handler in pairs(self.fixedUpdateHandlers) do
    handler(key, dt)
  end
end

function M:mousemoved(x, y, dx, dy, istouch)
  self.accumulatedMouseDx = self.accumulatedMouseDx + dx
  self.accumulatedMouseDy = self.accumulatedMouseDy + dy
end

function M:readMouseMovement()
  local dx = self.accumulatedMouseDx
  local dy = self.accumulatedMouseDy

  self.accumulatedMouseDx = 0
  self.accumulatedMouseDy = 0

  return dx, dy
end

return M
