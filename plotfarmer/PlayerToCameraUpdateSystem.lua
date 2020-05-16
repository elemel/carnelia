local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.playerEntities = assert(self.game.componentEntitySets.player)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:__call(dt)
  local transforms = self.transformComponents.transforms

  for playerId in pairs(self.playerEntities) do
    for cameraId in pairs(self.cameraEntities) do
      local playerX, playerY = transforms[playerId]:transformPoint(0, 0)
      local cameraX, cameraY = transforms[cameraId]:transformPoint(0, 0)

      local squaredDistance = heart.math.squaredDistance2(
        playerX, playerY, cameraX, cameraY)

      local maxDistance = 0.5

      if squaredDistance > maxDistance * maxDistance then
        local directionX, directionY = heart.math.normalize2(
          cameraX - playerX, cameraY - playerY)

        cameraX = playerX + maxDistance * directionX
        cameraY = playerY + maxDistance * directionY

        transforms[cameraId]:setTransformation(cameraX, cameraY, 0, 15)
      end
    end
  end
end

return M
