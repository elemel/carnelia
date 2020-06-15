return {
  components = {
    player = {},
    character = {},
    characterLowerState = {},
    characterUpperState = {},
    bone = {},

    body = {
      bodyType = "dynamic",
      -- gravityScale = 0,
    },

    raySensor = {
      ray = {0, 0, 0, 1.75},
    },

    groundFilter = {},
  },

  children = {
    {
      components = {
        bone = {
          transform = {0, -0.125},
        },

        circleFixture = {
          radius = 0.375,
        },
      },
    },

    {
      components = {
        bone = {
          transform = {0, 0.125},
        },

        circleFixture = {
          radius = 0.375,
        },
      },
    },

    {
      components = {
        bone = {
          transform = {0, 0, 0, 1 / 32, 1 / 32, 12, 16.5},
        },

        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/farmer/trunk.png",
          normalMap = "carnelia/resources/images/farmer/trunkNormal.png",
        },
      },
    },

    {
      components = {
        head = {},

        bone = {
          transform = {0, 0.55, 0, 1 / 32, 1 / 32, 10, 8},
          z = -0.1,
        },

        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/farmer/head.png",
          normalMap = "carnelia/resources/images/farmer/headNormal.png",
        },
      },
    },

    {
      components = {
        bone = {
          transform = {-0.2, -0.1, 0.1, 1 / 32, 1 / 32, 17, 23.5},
          z = 0.2,
        },

        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/sandbag.png",
          normalMap = "carnelia/resources/images/sandbagNormal.png",
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.arm",

      components = {
        left = {},

        bone = {
          transform = {0.15, -0.3, 0.25 * math.pi},
          z = 0.2,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.arm",

      components = {
        right = {},

        bone = {
          transform = {-0.15, -0.3, 0.25 * math.pi},
          z = -0.2,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.leg",

      components = {
        left = {},

        bone = {
          transform = {0.1, 0.3, -0.25 * math.pi},
          z = 0.1,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.leg",

      components = {
        right = {},

        bone = {
          transform = {-0.1, 0.3, -0.25 * math.pi},
          z = -0.1,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.plant",
    },
  },
}
