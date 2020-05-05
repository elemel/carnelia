local heart = require("heart")

function love.load()
  love.window.setTitle("Plotfarmer")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    -- highdpi = true,
  })

  love.graphics.setDefaultFilter("linear", "nearest")
  love.physics.setMeter(1)

  local assetLoaders = {
    image = heart.graphics.ImageLoader.new(),
  }

  local config = require("assets.game")
  game = heart.Game.new(assetLoaders, config)
end

function love.draw()
  game:handleEvent("draw")
end

function love.resize(width, height)
  game:handleEvent("resize", width, height)
end

function love.update(dt)
  game:handleEvent("update", dt)
end

function love.mousemoved(x, y, dx, dy, istouch)
  game:handleEvent("mouseMoved", x, y, dx, dy, istouch)
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
