local heart = require("heart")

local M = heart.class.newClass()

function M:init(game, system)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.plantEntities = assert(self.game.componentEntitySets.plant)

  self.characterComponents = assert(self.game.componentManagers.character)
  self.plantComponents = assert(self.game.componentManagers.plant)
  self.plantStateComponents = assert(self.game.componentManagers.plantState)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:handleEvent(dt)
  local bodies = self.physicsDomain.bodies
  local distanceJoints = self.physicsDomain.distanceJoints
  local transforms = self.transformComponents.transforms
  local directionXs = self.characterComponents.directionXs
  local states = self.plantStateComponents.states

  local localXs = self.plantComponents.localXs
  local localYs = self.plantComponents.localYs

  for id in pairs(self.plantEntities) do
    local parentId = self.game.entityParents[id]

    if states[id] == "grabbing" then
      local x1, y1, x2, y2 = distanceJoints[id]:getAnchors()
      transforms[id]:setTransformation(x1, y1, 0.5 * math.pi)
    else
      local angle = math.atan2(localYs[id], localXs[id])
      local parentX, parentY = bodies[parentId]:getPosition()

      transforms[id]:setTransformation(parentX + localXs[id], parentY + localYs[id], angle, 1, directionXs[parentId])
    end
  end
end

return M
