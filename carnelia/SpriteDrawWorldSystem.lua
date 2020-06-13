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

    vec4 normalDepth = 2 * Texel(normalMap, texture_coords) - 1;
    mat3 norm_matrix = mat3(1, 0, 0, 0, 1, 0, 0, 0, 1.0 / 32.0) * mat3(transformx);
    vec3 normal = normalize(norm_matrix * vec3(normalDepth));
    vec3 sunColor = 5 * vec3(texturecolor) * dot(normal, normalize(vec3(0, -1, 0.25))) * vec3(1.0, 0.75, 0.5);
    vec3 skyColor = 0.5 * vec3(texturecolor) * vec3(0.5, 0.75, 1.0);

    gl_FragDepth = 0.5 + 0.01 * (transformx * vec4(0, 0, 0, 1)).z - 0.005 * normalDepth.w;

    return vec4(sunColor + skyColor, 1);
}

]])

  self.normalMap = love.graphics.newImage("carnelia/resources/images/terrain/rock4x4Normal.png", {linear = true})
end

function M:handleEvent(viewportId)
  local transforms = self.spriteComponents.transforms
  local images = self.spriteComponents.images

  love.graphics.setDepthMode("less", true)
  love.graphics.setShader(self.shader)

  for id in pairs(self.spriteEntities) do
    self.shader:send("transformx", transforms[id])
    self.shader:send("normalMap", self.normalMap)
    love.graphics.draw(images[id], transforms[id])
  end

  love.graphics.setShader()
  love.graphics.setDepthMode()
end

return M
