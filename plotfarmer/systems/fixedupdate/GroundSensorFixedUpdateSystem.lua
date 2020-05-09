local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.groundSensorManager = assert(self.game.componentManagers.groundSensor)
  self.physicsDomain = assert(self.game.domains.physics)
end

function M:__call(dt)
  for id, localRay in pairs(self.groundSensorManager.localRays) do
    local body = self.physicsDomain.bodies[id]
    local x1, y1, x2, y2 = unpack(localRay)

    x1, y1 = body:getWorldPoint(x1, y1)
    x2, y2 = body:getWorldPoint(x2, y2)

    local contactFixture, contactX, contactY, contactNormalX, contactNormalY

    local function callback(fixture, x, y, xn, yn, fraction)
      local bodyType = fixture:getBody():getType()

      if bodyType ~= "dynamic" and not fixture:isSensor() then
        contactFixture = fixture

        contactX = x
        contactY = y

        contactNormalX = xn
        contactNormalY = yn

        return fraction
      end

      return 1
    end

    self.physicsDomain.world:rayCast(x1, y1, x2, y2, callback)

    local contact = self.groundSensorManager.contacts[id]
    contact.fixture = contactFixture

    if contactFixture then
      contact.x = contactX
      contact.y = contactY

      contact.normalX = contactNormalX
      contact.normalY = contactNormalY

      contact.linearVelocityX, contact.linearVelocityY =
        contactFixture:getBody():getLinearVelocityFromWorldPoint(
          contactX, contactY)

      contact.angularVelocity = contactFixture:getBody():getAngularVelocity()
    else
      contact.x = x2
      contact.y = y2

      contact.normalX = 0
      contact.normalY = -1

      contact.linearVelocityX = 0
      contact.linearVelocityY = 0

      contact.angularVelocity = 0
    end
  end
end

return M
