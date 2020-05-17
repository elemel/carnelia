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
    },

    groundSensor = {
      ray = {0, 0, 0, 1.5},
    },
  },

  children = {
    {
      components = {
        transform = {
          transform = {0, 0, 0, 1 / 32, 1 / 32, 18.5, 16.5},
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
          z = 0.1,
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-0.4, -0.3, -0.3, 1 / 32, 1 / 32, 32, 32},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "plotfarmer/resources/images/sandbag.png",
          z = -0.1,
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

        rectangleFixture = {
          width = 0.75,
          height = 0.75,
          friction = 5,
        },

        wheelJoint = {
          springFrequency = 5,
          maxMotorTorque = 50,
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
              transform = {0, 0, 0, 1 / 32, 1 / 32, 22, 24},
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
