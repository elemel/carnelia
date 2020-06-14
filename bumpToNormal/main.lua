local argparse = require("argparse")

local function colorToDepth(r, g, b, a)
  return 2 * a * (r + g + b) / 3 - 1
end

local function normalize2(x, y)
  local length = math.sqrt(x * x + y * y)
  return x / length, y / length
end

local function normalize3(x, y, z)
  local length = math.sqrt(x * x + y * y + z * z)
  return x / length, y / length, z / length
end

local function cross3(x1, y1, z1, x2, y2, z2)
  return y1 * z2 - z1 * y2, z1 * x2 - x1 * z2, x1 * y2 - y1 * x2
end

local function readBinaryFile(filename)
  local file = assert(io.open(filename, "rb"))
  local contents = file:read("*a")
  file:close()
  return contents
end

local function writeBinaryFile(filename, contents)
  local file = assert(io.open(filename, "wb"))
  file:write(contents)
  file:close()
end

function love.load(arg)
  love.window.setTitle("Bump to Normal")
  love.graphics.setDefaultFilter("linear", "nearest")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
  })

  local parser = argparse("love DIRECTORY", "Convert bump map to normal map")
  parser:argument("input", "Filename of bump map to read")
  parser:argument("output", "Filename of normal map to write")
  local parsedArgs = parser:parse(arg)

  local depthContents = readBinaryFile(parsedArgs.input)
  depthData = love.image.newImageData(love.filesystem.newFileData(depthContents, parsedArgs.input))
  depthImage = love.graphics.newImage(depthData, {linear = true})

  local width, height = depthImage:getDimensions()
  normalData = love.image.newImageData(width, height)

  for y = 0, height - 1 do
    local y1 = math.max(0, y - 1)
    local y2 = math.min(y + 1, height - 1)

    for x = 0, width - 1 do
      local z = depthData:getPixel(x, y)

      local x1 = math.max(0, x - 1)
      local x2 = math.min(x + 1, width - 1)

      local zx1 = colorToDepth(depthData:getPixel(x1, y))
      local zx2 = colorToDepth(depthData:getPixel(x2, y))

      local zy1 = colorToDepth(depthData:getPixel(x, y1))
      local zy2 = colorToDepth(depthData:getPixel(x, y2))

      local dx, dzdx = normalize2(x2 - x1, zx2 - zx1)
      local dy, dzdy = normalize2(y2 - y1, zy2 - zy1)

      local normalX, normalY, normalZ = normalize3(cross3(dx, 0, dzdx, 0, dy, dzdy))
      normalData:setPixel(x, y, 0.5 + 0.5 * normalX, 0.5 + 0.5 * normalY, 0.5 + 0.5 * normalZ, z)
    end
  end

  writeBinaryFile(parsedArgs.output, normalData:encode("png"):getString())
  normalImage = love.graphics.newImage(normalData, {linear = true})
end

function love.draw()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local depthWidth, depthHeight = depthImage:getDimensions()
  local normalWidth, normalHeight = normalImage:getDimensions()

  local depthScale = math.min(0.5 * windowWidth / depthWidth, windowHeight / depthHeight)
  local normalScale = math.min(0.5 * windowWidth / normalWidth, windowHeight / normalHeight)

  love.graphics.draw(depthImage, 0.25 * windowWidth - 0.5 * normalScale * depthWidth, 0.5 * windowHeight - 0.5 * normalScale * depthHeight, 0, depthScale)
  love.graphics.draw(normalImage, 0.75 * windowWidth - 0.5 * normalScale * normalWidth, 0.5 * windowHeight - 0.5 * normalScale * normalHeight, 0, normalScale)
end
