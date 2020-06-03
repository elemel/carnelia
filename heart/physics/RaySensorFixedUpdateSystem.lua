local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.raySensorEntities = assert(self.game.componentEntitySets.raySensor)
  self.raySensorComponents = assert(self.game.componentManagers.raySensor)
end

function M:handleEvent(dt)
  local filters = self.raySensorComponents.filters
  local bodies = self.physicsDomain.bodies
  local contacts = self.raySensorComponents.contacts

  local localXs = self.raySensorComponents.localXs
  local localYs = self.raySensorComponents.localYs

  local offsetXs = self.raySensorComponents.offsetXs
  local offsetYs = self.raySensorComponents.offsetYs

  for id in pairs(self.raySensorEntities) do
    local body = bodies[id]
    local filter = filters[id]

    local x1, y1 = body:getWorldPoint(localXs[id], localYs[id])

    local x2 = x1 + offsetXs[id]
    local y2 = y1 + offsetYs[id]

    local contactFixture, contactX, contactY, contactNormalX, contactNormalY

    local function callback(fixture, x, y, normalX, normalY, fraction)
      if filter and not filter(id, fixture, x, y, normalX, normalY) then
        return 1
      end

      contactFixture = fixture

      contactX = x
      contactY = y

      contactNormalX = normalX
      contactNormalY = normalY

      return fraction
    end

    self.physicsDomain.world:rayCast(x1, y1, x2, y2, callback)

    if contactFixture then
      contacts[id] = contacts[id] or {}
      local contact = contacts[id]

      contact.fixture = contactFixture

      contact.x = contactX
      contact.y = contactY

      contact.normalX = contactNormalX
      contact.normalY = contactNormalY
    else
      contacts[id] = nil
    end
  end
end

return M
