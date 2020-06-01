return {
  components = {
    plantState = {},

    plant = {
      localX = 1,
    },

    transform = {},

    bone = {},

    parentConstraint = {
      enabled = false,
    },
  },

  children = {
    {
      components = {
        transform = {
          transform = {0, 0, -0.375 * math.pi},
        },

        bone = {},
        parentConstraint = {},
      },

      children = {
        {
          components = {
            transform = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 3, 11},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "carnelia/resources/images/plant/upperJaw.png",
              z = -0.1,
            },
          },
        },
      },
    },

    {
      components = {
        transform = {
          transform = {0, 0, 0.375 * math.pi},
        },

        bone = {},
        parentConstraint = {},
      },

      children = {
        {
          components = {
            transform = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 3, 3},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "carnelia/resources/images/plant/lowerJaw.png",
              z = -0.1,
            },
          },
        },
      },
    },
  },
}
