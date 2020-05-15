local M = {}

function M.solve(x1, y1, x2, y2, length)
  local x = 0.5 * (x1 + x2)
  local y = 0.5 * (y1 + y2)

  local squaredDistance = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
  local squaredDoubleOffset = length * length - squaredDistance

  if squaredDistance > 0 and squaredDoubleOffset > 0 then
    local distance = math.sqrt(squaredDistance)
    local offset = 0.5 * math.sqrt(squaredDoubleOffset)

    local normalX = (y2 - y1) / distance
    local normalY = (x1 - x2) / distance

    x = x + offset * normalX
    y = y + offset * normalY
  end

  return x, y
end

return M
