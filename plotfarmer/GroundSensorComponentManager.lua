local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.transformManager = assert(self.game.componentManagers.transform)
  self.localRays = {}
  self.contacts = {}
end

function M:createComponent(id, config)
  local transform = self.transformManager.transforms[id]
  local body = self.physicsDomain.bodies[id]
  local ray = config.ray or {0, 0, 0, 1}
  local x1, y1, x2, y2 = unpack(ray)

  x1, y1 = body:getLocalPoint(transform:transformPoint(x1, y1))
  x2, y2 = body:getLocalPoint(transform:transformPoint(x2, y2))

  self.localRays[id] = {x1, y1, x2, y2}

  self.contacts[id] = {
    x = 0,
    y = 0,
    normalX = 0,
    normalY = 0,
    linearVelocityX = 0,
    linearVelocityY = 0,
    angularVelocity = 0,
  }
end

function M:destroyComponent(id)
  self.localRays[id] = nil
  self.contacts[id] = nil
end

return M
