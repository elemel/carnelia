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
  love.mouse.setRelativeMode(true)
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
  if key == "1" then
    local timestamp = os.date('%Y-%m-%d-%H-%M-%S')
    local filename = "screenshot-" .. timestamp .. ".png"
    love.graphics.captureScreenshot(filename)

    local directory = love.filesystem.getSaveDirectory()
    print("Captured screenshot: " .. directory .. "/" .. filename)
  elseif key == "2" then
    if love.window.getFullscreen() then
      love.window.setFullscreen(false)

      -- Work-around for missing resize event in LÖVE 11.3 (macOS Mojave)
      love.resize(love.graphics.getDimensions())
    else
      love.window.setFullscreen(true)
    end
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
  game:mousemoved(x, y, dx, dy, istouch)
end
