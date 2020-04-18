local Game = require("Game")
local Plantfarmer = require("Plantfarmer")

function love.load()
  love.window.setTitle("Plantfarmer")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
  })

  love.physics.setMeter(1)
  love.graphics.setDefaultFilter("linear", "nearest")
  game = Game.new()
  Plantfarmer.new(game, {y = -3})
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.resize(width, height)
  game:resize(width, height)
end
