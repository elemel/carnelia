local class = require("class")

local InputDomain = class.new()

function InputDomain:init(game, config)
  self.handlers = {}
end

function InputDomain:fixedUpdate(dt)
  for key, handler in pairs(self.handlers) do
    handler(key, dt)
  end
end

return InputDomain
