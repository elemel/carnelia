local M = {}

function M.distance(x1, y1, x2, y2)
  return M.length(x2 - x1, y2 - y1)
end

function M.length(x, y)
  return math.sqrt(x * x + y * y)
end

return M
