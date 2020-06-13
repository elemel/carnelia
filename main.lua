local argparse = require("argparse")
local heart = require("heart")

function love.load(arg)
  local parser = argparse("love DIRECTORY", "Carnelia: Keep it alive")
  parser:argument("level", "Level name"):args("?")
  local parsed_args = parser:parse(arg)

  love.window.setTitle("Carnelia")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    -- highdpi = true,
    -- vsync = false,
  })

  love.physics.setMeter(1)

  -- Work-around for freeze while pressing mouse in LÖVE 11.3 (macOS Mojave)
  love.event.pump()

  love.mouse.setRelativeMode(true)

  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new(),
  }

  local gameConfig = require("carnelia.resources.configs.game")
  local levelName = parsed_args.level or "grassland"
  local levelConfig = require("carnelia.resources.configs.levels." .. levelName)
  local config = setmetatable({entities = levelConfig.entities}, {__index = gameConfig})
  game = heart.Game.new(resourceLoaders, config)
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
  game:handleEvent("mousemoved", x, y, dx, dy, istouch)
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
