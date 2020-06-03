local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.transformComponents = assert(self.game.componentManagers.transform)

  self.localXs = {}
  self.localYs = {}

  self.offsetXs = {}
  self.offsetYs = {}

  self.filters = {}
  self.contacts = {}
end

function M:createComponent(id, config)
  local transform = self.transformComponents.transforms[id]
  local body = self.physicsDomain.bodies[id]

  local x = config.x or 0
  local y = config.y or 0

  self.localXs[id], self.localYs[id] =
    body:getLocalPoint(transform:transformPoint(x, y))

  self.offsetXs[id] = config.offsetX or 0
  self.offsetYs[id] = config.offsetY or 1.25
end

function M:destroyComponent(id)
  self.localXs[id] = nil
  self.localYs[id] = nil

  self.offsetXs[id] = nil
  self.offsetYs[id] = nil

  self.filters[id] = nil
  self.contacts[id] = nil
end

return M
