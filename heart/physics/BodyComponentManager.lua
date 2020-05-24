local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.localTransforms = {}
end

function M:createComponent(id, config)
  local transform = self.transformComponents.transforms[id]
  local x = config.x or 0
  local y = config.y or 0
  x, y = transform:transformPoint(x, y)
  local angle = config.angle or 0
  angle = heartMath.transformAngle(transform, angle)

  self.localTransforms[id] = transform:clone():rotate(-angle):translate(-x, -y)

  local bodyType = config.bodyType or "static"
  local body = love.physics.newBody(self.physicsDomain.world, x, y, bodyType)
  body:setUserData(id)
  body:setAngle(angle)
  local linearVelocityX = config.linearVelocityX or 0
  local linearVelocityY = config.linearVelocityY or 0
  body:setLinearVelocity(linearVelocityX, linearVelocityY)
  body:setAngularVelocity(config.angularVelocity or 0)
  body:setFixedRotation(config.fixedRotation or false)
  body:setGravityScale(config.gravityScale or 1)
  body:setSleepingAllowed(config.sleepingAllowed ~= false)
  self.physicsDomain.bodies[id] = body
  return body
end

function M:destroyComponent(id)
  self.localTransforms[id] = nil

  self.physicsDomain.bodies[id]:destroy()
  self.physicsDomain.bodies[id] = nil
end

return M
