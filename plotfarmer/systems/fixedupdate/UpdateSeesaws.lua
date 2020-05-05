local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.seesawEntities = assert(self.game.componentEntitySets.seesaw)
  self.physicsDomain = assert(self.game.domains.physics)
  self.fixedTime = 0
end

function M:__call(dt)
  self.fixedTime = self.fixedTime + dt
  local targetAngle = 0.125 * math.pi * math.sin(self.fixedTime)

  local bodies = self.physicsDomain.bodies

  for id in pairs(self.seesawEntities) do
    local body = bodies[id]
    local currentAngle = body:getAngle()
    body:setAngularVelocity((targetAngle - currentAngle) / dt)
  end
end

return M
