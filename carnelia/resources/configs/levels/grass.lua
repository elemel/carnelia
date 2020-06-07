return {
  entities = {
    {
      components = {
        transform = {
          transform = {0, 0, 0, 15},
        },

        bone = {},
        camera = {},
        viewport = {},
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.terrain.grass4x2",

      components = {
        transform = {
          transform = {-6.7, 3.7, 0.6},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.terrain.grassTop4x2",

      components = {
        transform = {
          transform = {-0.5, 3.5, 0},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.terrain.grassBottom4x2",

      components = {
        transform = {
          transform = {5, 0, 0},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.seesaw",
    },

    {
      prototype = "carnelia.resources.configs.entities.farmer",

      components = {
        transform = {
          transform = {-3, -3},
        },
      },
    },

    {
      components = {
        water = {},

        transform = {
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
        transform = {
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
            transform = {
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
