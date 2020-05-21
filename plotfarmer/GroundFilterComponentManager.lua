local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.raySensorComponents = assert(self.game.componentManagers.raySensor)

  self.filter = function(id, fixture, x, y, normalX, normalY)
    return fixture:getBody():getType() ~= "dynamic" and not fixture:isSensor()
  end
end

function M:createComponent(id, config)
  self.raySensorComponents.filters[id] = self.filter
end

function M:destroyComponent(id)
  self.raySensorComponents.filters[id] = nil
end

return M
