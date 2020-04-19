local Game = require("Game")
local PlantFarmer = require("PlantFarmer")

function love.load()
  love.window.setTitle("Plant Farmer")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
  })

  love.filesystem.setIdentity("plant-farmer")

  love.physics.setMeter(1)
  love.graphics.setDefaultFilter("linear", "nearest")
  game = Game.new()
  PlantFarmer.new(game, {y = -2})
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

function love.keypressed(key, scancode, isrepeat)
  if key == "backspace" then
    local timestamp = os.date('%Y-%m-%d-%H-%M-%S')
    local filename = "screenshot-" .. timestamp .. ".png"
    love.graphics.captureScreenshot(filename)

    local directory = love.filesystem.getSaveDirectory()
    print("Captured screenshot: " .. directory .. "/" .. filename)
  end
end
