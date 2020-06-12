return {
  entities = {
    {
      components = {
        bone = {
          transform = {0, 0, 0, 15},
        },

        camera = {},
        viewport = {},
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.farmer",

      components = {
        bone = {
          transform = {-10, 5},
        },
      },
    },

    {
      components = {
        water = {},

        bone = {
          transform = {0, 10},
        },

        body = {},

        rectangleFixture = {
          width = 50,
          height = 5,

          sensor = true,
        },
      },
    },

    {
      components = {
        bone = {
          transform = {-10, 8},
        },

        bone = {},

        body = {
          bodyType = "dynamic",
          linearDamping = 0.5,
          angularDamping = 0.5,
        },

        rectangleFixture = {
          width = 8,
          height  = 1,
        },
      },

      children = {
        {
          components = {
            bone = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 128, 16},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "carnelia/resources/images/raft.png",
              z = 0.1,
            },
          },
        },
      },
    },
  },
}
