return {
  components = {
    player = {},
    character = {},
    characterLowerState = {},
    characterUpperState = {},
    transform = {},
    bone = {},

    body = {
      bodyType = "dynamic",
    },

    raySensor = {
      ray = {0, 0, 0, 1.75},
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
          image = "carnelia/resources/images/farmer/trunk.png",
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
          image = "carnelia/resources/images/farmer/head.png",
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
          image = "carnelia/resources/images/sandbag.png",
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.arm",

      components = {
        left = {},

        transform = {
          transform = {-0.15, -0.3, 0.25 * math.pi},
          z = 0.1,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.arm",

      components = {
        right = {},

        transform = {
          transform = {0.15, -0.3, 0.25 * math.pi},
          z = -0.1,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.leg",

      components = {
        left = {},

        transform = {
          transform = {0.1, 0.3, -0.25 * math.pi},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.leg",

      components = {
        right = {},

        transform = {
          transform = {-0.1, 0.3, -0.25 * math.pi},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.plant",
    },
  },
}
