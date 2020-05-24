local M = {}

function M.solve(x1, y1, x2, y2, length)
  local direction = length < 0 and -1 or 1
  length = math.abs(length)
  local squaredDistance = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)

  if squaredDistance == 0 then
    return x2, y2, x2, y2
  end

  local distance = math.sqrt(squaredDistance)

  local tangentX = (x2 - x1) / distance
  local tangentY = (y2 - y1) / distance

  local squaredDoubleOffset = length * length - squaredDistance

  if squaredDoubleOffset <= 0 then
    x2 = x1 + length * tangentX
    y2 = y1 + length * tangentY

    local x = 0.5 * (x1 + x2)
    local y = 0.5 * (y1 + y2)

    return x, y, x2, y2
  end

  local offset = 0.5 * math.sqrt(squaredDoubleOffset)

  local normalX = direction * tangentY
  local normalY = direction * -tangentX

  local x = 0.5 * (x1 + x2) + offset * normalX
  local y = 0.5 * (y1 + y2) + offset * normalY

  return x, y, x2, y2
end

return M
