local class = require("class")

local M = class.new()

function M:init(game, config)
  self.bones = {}
  self.updateHandlers = {}
end

function M:update(dt)
  for key, handler in pairs(self.updateHandlers) do
    handler(key, dt)
  end
end

return M
