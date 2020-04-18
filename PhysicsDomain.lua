local class = require("class")

local M = class.new()

function M:init(game, config)
  self.game = assert(game)
  self.world = love.physics.newWorld(0, 34)
  self.nextGroupIndex = 1
end

function M:fixedUpdate(dt)
  self.world:update(dt)
end

function M:debugDraw()
  love.graphics.setColor(0, 1, 0, 1)

  for _, body in ipairs(self.world:getBodies()) do
    for _, fixture in ipairs(body:getFixtures()) do
      local shape = fixture:getShape()
      local shapeType = shape:getType()

      if shapeType == "chain" then
        love.graphics.line(body:getWorldPoints(shape:getPoints()))
      elseif shapeType == "circle" then
        local x, y = body:getWorldPoint(shape:getPoint())
        local r = shape:getRadius()

        love.graphics.push()
        love.graphics.translate(x, y)
        love.graphics.rotate(body:getAngle())
        love.graphics.circle("line", 0, 0, r, 16)
        love.graphics.line(0, 0, r, 0)
        love.graphics.pop()
      elseif shapeType == "polygon" then
        love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
      else
        error("Unknown shape type: " .. shapeType)
      end
    end
  end

  love.graphics.setColor(1, 1, 1, 1)
end

function M:generateGroupIndex()
  local result = self.nextGroupIndex
  self.nextGroupIndex = self.nextGroupIndex + 1
  return result
end

return M
