local Game = require("Game")
local PlantFarmer = require("PlantFarmer")

function love.load()
  love.window.setTitle("Plant Farmer")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
  })

  love.physics.setMeter(1)
  love.graphics.setDefaultFilter("linear", "nearest")
  game = Game.new()
  PlantFarmer.new(game, {y = -3})
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
