return {
  components = {
    player = {},
    character = {},
    characterState = {},
    transform = {},
    bone = {},

    body = {
      bodyType = "dynamic",
      fixedRotation = true,
    },

    raySensor = {
      ray = {0, 0, 0, 1.5},
    },

    groundFilter = {},
  },

  children = {
    {
      components = {
        transform = {
          transform = {0, -0.625},
        },

        circleFixture = {
          radius = 0.25,
        },
      },
    },

    {
      components = {
        transform = {
          transform = {0, -0.125},
        },

        circleFixture = {
          radius = 0.375,
        },
      },
    },

    {
      components = {
        transform = {
          transform = {0, 0.125},
        },

        circleFixture = {
          radius = 0.375,
        },
      },
    },

    {
      components = {
        transform = {
          transform = {0, 0, 0, 1 / 32, 1 / 32, 12, 16.5},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "plotfarmer/resources/images/skins/player/trunk.png",
        },
      },
    },

    {
      components = {
        head = {},

        transform = {
          transform = {0, 0.55, 0, 1 / 32, 1 / 32, 10, 8},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "plotfarmer/resources/images/skins/player/head.png",
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-0.2, -0.1, 0.1, 1 / 32, 1 / 32, 17, 23.5},
          z = -0.1,
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "plotfarmer/resources/images/sandbag.png",
        },
      },
    },

    {
      prototype = "plotfarmer.resources.configs.entities.arm",

      components = {
        left = {},

        transform = {
          transform = {-0.125, -0.25, 0.25 * math.pi},
          z = 0.1,
        },
      },
    },

    {
      prototype = "plotfarmer.resources.configs.entities.leg",

      components = {
        left = {},

        transform = {
          transform = {0.125, 0.25, -0.25 * math.pi},
        },
      },
    },

    {
      prototype = "plotfarmer.resources.configs.entities.leg",

      components = {
        right = {},

        transform = {
          transform = {-0.125, 0.25, -0.25 * math.pi},
        },
      },
    },

    {
      components = {
        plant = {},

        transform = {
          transform = {0, -3},
        },

        bone = {},
        parentConstraint = {},
      },

      children = {
        {
          components = {
            transform = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 19, 15},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "plotfarmer/resources/images/plant.png",
              z = -0.1,
            },
          },
        },
      },
    },
  },
}
