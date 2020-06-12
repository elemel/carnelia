return {
  components = {
    bone = {},

    body = {
      bodyType = "static",
    },

    chainFixture = {
      points = {
        -2.4, 0.6,
        -1.9, 0.9,
        -1.3, 1.1,
        -0.7, 1.2,
        0, 1.25,
        0.7, 1.2,
        1.9, 0.9,
        1.3, 1.1,
        2.4, 0.6,

        1.7, -1.25,
        0.95, -1,
        0, -0.85,
        -0.95, -1,
        -1.7, -1.25,
      },

      loop = true,
      friction = 1,
    },
  },

  children = {
    {
      components = {
        bone = {
          transform = {0, -0.1, 0, 1 / 32, 1 / 32, 80, 46.5},
        },

        sprite = {
          image = "carnelia/resources/images/terrain/grassBottom4x2.png",
        },
      },
    },
  },
}
