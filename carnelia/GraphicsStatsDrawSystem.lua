local heart = require("heart")

local M = heart.class.newClass()

local function formatNumber(n)
  if math.abs(n) >= 1000000 then
    return string.format("%.3gM", 1e-6 * n)
  elseif math.abs(n) >= 1000 then
    return string.format("%.3gK", 1e-3 * n)
  else
    return string.format("%.3g", n)
  end
end

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.fontSize = config.fontSize or 12
  self.font = love.graphics.newFont(self.fontSize)
  self.text = love.graphics.newText(self.font)
  self.stats = {}

end

-- TODO: Update text once per second
-- TODO: Maybe accumulate average between updates
function M:handleEvent()
  local stats = love.graphics.getStats(self.stats)

  local text =
    stats.drawcalls .. " draw calls\n" ..
    stats.canvasswitches .. " canvas switches\n" ..
    formatNumber(stats.texturememory) .. " texture memory\n" ..
    stats.images .. " images\n" ..
    stats.canvases .. " canvases\n" ..
    stats.fonts .. " fonts\n" ..
    stats.shaderswitches .. " shader switches\n" ..
    stats.drawcallsbatched .. " draw calls batched"

  self.text:set({self.color, text})
  love.graphics.draw(self.text, self.fontSize, self.fontSize)
end

return M
