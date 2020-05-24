local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)

  self.boneEntities = assert(self.game.componentEntitySets.bone)

  self.bodyComponents = assert(self.game.componentManagers.body)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:handleEvent(dt)
  local bodies = self.physicsDomain.bodies
  local transforms = self.transformComponents.transforms
  local localTransforms = self.bodyComponents.localTransforms

  for id in pairs(self.boneEntities) do
    local body = bodies[id]

    if body then
      local x, y = body:getPosition()
      local angle = body:getAngle()
      transforms[id]:setTransformation(x, y, angle):apply(localTransforms[id])
    end
  end
end

return M
