local class = require("class")
local PhysicsDomain = require("PhysicsDomain")

local Game = class.new()

function Game:init()
  self.fixedDt = 1 / 60
  self.accumulatedDt = 0

  self.physicsDomain = PhysicsDomain.new(self, {})
end

function Game:update(dt)
  self.accumulatedDt = self.accumulatedDt + dt

  while self.accumulatedDt >= self.fixedDt do
    self.accumulatedDt = self.accumulatedDt - self.fixedDt
    self:fixedUpdate(self.fixedDt)
  end
end

function Game:fixedUpdate(dt)
  self.physicsDomain:fixedUpdate(dt)
end

function Game:draw()
  self.physicsDomain:debugDraw()
end

return Game
