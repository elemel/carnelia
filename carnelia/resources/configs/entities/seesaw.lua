return {
  components = {
    transform = {},
    bone = {},

    body = {
      bodyType = "kinematic",
    },

    rectangleFixture = {
      width = 16,
      height = 0.5,
      friction = 1,
      -- sensor = true,
    },

    seesaw = {},
  },

  children = {
    {
      components = {
        transform = {
          transform = {0, 0, 0, 1 / 32, 1 / 32, 256, 8},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/seesaw.png",
          z = 0.1,
        },
      },
    },
  },
}
