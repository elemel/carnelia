local Game = require("Game")

function love.load()
  love.window.setTitle("Plantfarmer")
  game = Game.new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end
