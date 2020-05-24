local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.spriteComponents = assert(self.game.componentManagers.sprite)

  self.hardFlipEnabled = config.hardFlipEnabled == true
end

function M:handleEvent(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timerDomain:getFraction()
  local spriteTransforms = self.spriteComponents.transforms
  local zs = self.spriteComponents.zs

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      local hardFlip = false

      if self.hardFlipEnabled then
        local _, _, _, sx1, sy1 = heartMath.decompose2(previousTransforms[id])
        local _, _, _, sx2, sy2 = heartMath.decompose2(transforms[id])

        hardFlip = sx1 * sy1 * sx2 * sy2 < 0
      end

      if hardFlip then
        spriteTransforms[id]:reset():apply(transforms[id])
      else
        _, zs[id] = heartMath.mixTransforms(
          previousTransforms[id], transforms[id], t, spriteTransforms[id])
      end
    end
  end
end

return M
