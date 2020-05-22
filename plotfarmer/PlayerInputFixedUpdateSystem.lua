local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)

  self.physicsDomain = assert(self.game.domains.physics)
  self.timerDomain = assert(self.game.domains.timer)

  self.playerEntities = assert(self.game.componentEntitySets.player)

  self.characterStateComponents = assert(self.game.componentManagers.characterState)
  self.raySensorComponents = assert(self.game.componentManagers.raySensor)
end

function M:__call(dt)
  local fixedTime = self.timerDomain:getFixedTime()

  local bodies = self.physicsDomain.bodies
  local states = self.characterStateComponents.states
  local contacts = self.raySensorComponents.contacts

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")
  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)

  for id in pairs(self.playerEntities) do
    contact = contacts[id]

    if contact then
      local body = bodies[id]
      local x, y = body:getPosition()
      local distance = heart.math.distance2(x, y, contact.x, contact.y)
      local targetDistance = 1.25

      if inputX ~= 0 then
        local angle = 20 * fixedTime
        targetDistance = targetDistance + 0.125 * math.sin(angle)
      end

      local positionError = targetDistance - distance
      local mass = body:getMass()
      local stiffness = 100
      local damping = 10
      local linearVelocityX, linearVelocityY = body:getLinearVelocity()

      local tangentX = contact.normalY
      local tangentY = -contact.normalX

      local contactLinearVelocityX, contactLinearVelocityY =
        contact.fixture:getBody():getLinearVelocityFromWorldPoint(contact.x, contact.y)

      local velocityErrorX = contactLinearVelocityX + 5 * inputX - linearVelocityX

      local velocityErrorY = contactLinearVelocityY - linearVelocityY - linearVelocityX * tangentY
      body:applyForce(0, -stiffness * mass * positionError + damping * mass * velocityErrorY)

      body:applyForce(-10 * mass * velocityErrorX * tangentX, -10 * mass * velocityErrorX * tangentY)
    end

    states[id] = inputX == 0 and "standing" or "running"
  end
end

return M
