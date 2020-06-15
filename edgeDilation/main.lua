local argparse = require("argparse")

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
  love.window.setTitle("Edge Dilation")
  love.graphics.setDefaultFilter("linear", "nearest")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
  })

  local parser = argparse("love DIRECTORY", "Dilate edges based on alpha channel")
  parser:argument("input", "Filename of input image")
  parser:argument("output", "Filename of output image"):args("?")
  local parsedArgs = parser:parse(arg)

  local inputContents = readBinaryFile(parsedArgs.input)
  inputData = love.image.newImageData(love.filesystem.newFileData(inputContents, parsedArgs.input))
  inputImage = love.graphics.newImage(inputData)

  local inputWidth, inputHeight = inputImage:getDimensions()
  outputData = love.image.newImageData(inputWidth, inputHeight)

  for y = 0, inputHeight - 1 do
    local y1 = math.max(0, y - 1)
    local y2 = math.min(y + 1, inputHeight - 1)

    for x = 0, inputWidth - 1 do
      if a == 0 then
        r = 0
        g = 0
        b = 0

        for y2 = math.max(0, y - 1), math.min(y + 1, inputHeight - 1) do
          for x2 = math.max(0, x - 1), math.min(x + 1, inputWidth - 1) do
            if x2 ~= x or y2 ~= y then
              local r2, g2, b2, a2 = inputData:getPixel(x2, y2)

              r = r + a2 * r2
              g = g + a2 * g2
              b = b + a2 * b2

              a = a + a2
            end
          end
        end

        if a ~= 0 then
          r = r / a
          g = g / a
          b = b / a

          a = 0
        end
      end

      outputData:setPixel(x, y, r, g, b, a)
    end
  end

  local outputFilename = parsedArgs.output or parsedArgs.input
  writeBinaryFile(outputFilename, outputData:encode("png"):getString())
  outputImage = love.graphics.newImage(outputData)
end

function love.draw()
  love.graphics.setBlendMode("replace", "premultiplied")

  local windowWidth, windowHeight = love.graphics.getDimensions()
  local inputWidth, inputHeight = inputImage:getDimensions()
  local outputWidth, outputHeight = outputImage:getDimensions()

  local inputScale = math.min(0.5 * windowWidth / inputWidth, windowHeight / inputHeight)
  local outputScale = math.min(0.5 * windowWidth / outputWidth, windowHeight / outputHeight)

  love.graphics.draw(inputImage, 0.25 * windowWidth - 0.5 * inputScale * inputWidth, 0.5 * windowHeight - 0.5 * inputScale * inputHeight, 0, inputScale)
  love.graphics.draw(outputImage, 0.75 * windowWidth - 0.5 * outputScale * outputWidth, 0.5 * windowHeight - 0.5 * outputScale * outputHeight, 0, outputScale)

  love.graphics.setBlendMode("alpha")
end
