local class = require("heart.class")
local heartMath = require("heart.math")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(self.game.domains.timer)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)
  self.spriteComponents = assert(self.game.componentManagers.sprite)

  self.shader = love.graphics.newShader([[

#pragma language glsl3

uniform mat4 transformx;
uniform Image normalMap;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec4 texturecolor = Texel(tex, texture_coords);

    if (texturecolor.a < 0.5) {
      discard;
    }

    mat3 norm_matrix = mat3(1, 0, 0, 0, 1, 0, 0, 0, 1.0 / 32.0) * mat3(transformx);
    vec3 normal = 2 * vec3(Texel(normalMap, texture_coords)) - 1;
    normal = normalize(norm_matrix * normal);
    vec3 sunColor = 5 * vec3(texturecolor) * dot(normal, normalize(vec3(0, -1, 0.25))) * vec3(1.0, 0.75, 0.5);
    vec3 skyColor = 0.5 * vec3(texturecolor) * vec3(0.5, 0.75, 1.0);
    return vec4(sunColor + skyColor, 1);
}

]])

  self.normalMap = love.graphics.newImage("carnelia/resources/images/terrain/rock4x4Normal.png", {linear = true})
end

function M:handleEvent(viewportId)
  local transforms = self.spriteComponents.transforms
  local ids = heartTable.keys(self.spriteEntities)
  local zs = self.spriteComponents.zs
  local epsilon = 1e-6

  table.sort(ids, function(a, b)
    return zs[a] + a * epsilon < zs[b] + b * epsilon
  end)

  local images = self.spriteComponents.images

  love.graphics.setShader(self.shader)
  self.shader:send("normalMap", self.normalMap)

  for _, id in ipairs(ids) do
    self.shader:send("transformx", transforms[id])
    love.graphics.draw(images[id], transforms[id])
  end

  love.graphics.setShader()
end

return M
