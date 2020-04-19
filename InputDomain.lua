local class = require("class")

local M = class.new()

function M:init(game, config)
  self.fixedUpdateHandlers = {}
end

function M:fixedUpdate(dt)
  for key, handler in pairs(self.fixedUpdateHandlers) do
    handler(key, dt)
  end
end

return M
