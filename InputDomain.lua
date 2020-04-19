local class = require("class")

local M = class.new()

function M:init(game, config)
  self.handlers = {}
end

function M:fixedUpdate(dt)
  for key, handler in pairs(self.handlers) do
    handler(key, dt)
  end
end

return M
