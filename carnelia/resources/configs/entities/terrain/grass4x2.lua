return {
  components = {
    transform = {},
    bone = {},

    body = {
      bodyType = "static",
    },

    rectangleFixture = {
      width = 4,
      height = 2,
      friction = 1,
    },
  },

  children = {
    {
      components = {
        transform = {
          transform = {0, -0.1, 0, 1 / 32, 1 / 32, 67, 38.5},
        },

        bone = {},

        sprite = {
          image = "carnelia/resources/images/terrain/grass4x2.png",
        },
      },
    },
  },
}
