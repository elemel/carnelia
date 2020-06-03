local M = {}

function M.isPointInsideLine(x, y, x1, y1, x2, y2)
  return (x - x1) * (y2 - y1) - (y - y1) * (x2 - x1) < 0
end

-- See: https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
function M.intersectLines(x1, y1, x2, y2, x3, y3, x4, y4)
  local x = (x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)
  local y = (x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)

  local divisor = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
  return x / divisor, y / divisor
end

function M.clipByLine(vertices, x1, y1, x2, y2, newVertices)
  newVertices = newVertices or {}

  local x3 = vertices[#vertices - 1]
  local y3 = vertices[#vertices]

  local inside3 = M.isPointInsideLine(x3, y3, x1, y1, x2, y2)

  for i = 1, #vertices, 2 do
      local x4 = vertices[i]
      local y4 = vertices[i + 1]

      local inside4 = M.isPointInsideLine(x4, y4, x1, y1, x2, y2)

      if inside4 ~= inside3 then
        local x, y = M.intersectLines(x3, y3, x4, y4, x1, y1, x2, y2)

        newVertices[#newVertices + 1] = x
        newVertices[#newVertices + 1] = y

        inside3 = inside4
      end

      if inside4 then
        newVertices[#newVertices + 1] = x4
        newVertices[#newVertices + 1] = y4
      end

      x3 = x4
      y3 = y4
  end

  return newVertices
end

-- See: https://en.wikipedia.org/wiki/Centroid#Centroid_of_a_polygon
function M.centroid(vertices)
  local x = 0
  local y = 0

  local totalZ = 0

  local x1 = vertices[#vertices - 1]
  local y1 = vertices[#vertices]

  for i = 1, #vertices, 2 do
      local x2 = vertices[i]
      local y2 = vertices[i + 1]

      local z = (x1 * y2 - x2 * y1)

      x = x + (x1 + x2) * z
      y = y + (y1 + y2) * z

      totalZ = totalZ + z

      x1 = x2
      y1 = y2
  end

  local scale = 1 / (3 * totalZ)
  return scale * x, scale * y, 0.5 * totalZ
end

return M
