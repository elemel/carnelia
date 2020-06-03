local heart = require("heart")

local ColorStack = require("carnelia.ColorStack")

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.colorStack = ColorStack.new()
end

function M:handleEvent()
  self.colorStack:push(unpack(self.color))
  love.graphics.print(love.timer.getFPS() .. " FPS")
  self.colorStack:pop()
end

return M
