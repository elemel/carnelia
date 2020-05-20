local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.playerEntities = assert(self.game.componentEntitySets.player)
  self.characterComponents = assert(self.game.componentManagers.character)
end

function M:__call(dt)
  local states = self.characterComponents.states

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")
  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)

  for id in pairs(self.playerEntities) do
    for _, wheelId in ipairs(self.game:findDescendantComponents(id, "wheel")) do
      local joint = self.physicsDomain.wheelJoints[wheelId]
      -- joint:setMotorEnabled(inputX ~= 0)
      joint:setMotorEnabled(true)
      joint:setMotorSpeed(5 * inputX / 0.375)
    end

    states[id] = inputX == 0 and "standing" or "running"
  end
end

return M
