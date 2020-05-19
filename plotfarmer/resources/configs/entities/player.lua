return {
  components = {
    player = {},
    transform = {},
    bone = {},

    body = {
      bodyType = "dynamic",
      fixedRotation = true,
    },

    circleFixture = {
      radius = 0.375,
      density = 2,
    },

    groundSensor = {
      ray = {0, 0, 0, 1.5},
    },
  },

  children = {
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
      components = {
        wheel = {},

        transform = {
          transform = {0, 0.75},
        },

        body = {
          bodyType = "dynamic",
        },

        -- rectangleFixture = {
        --   width = 0.75,
        --   height = 0.75,
        --   friction = 5,
        -- },

        circleFixture = {
          radius = 0.375,
          friction = 13,
          density = 0.5,
        },

        wheelJoint = {
          springFrequency = 5,
          springDampingRatio = 1,
          maxMotorTorque = 50,
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
