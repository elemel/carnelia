return {
  components = {
    transform = {},
    bone = {},
    parentConstraint = {},
  },

  children = {
    {
      components = {
        transform = {
          transform = {0, 0, 0, 1 / 32, 1 / 32, 6, 3},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/farmer/upperArm.png",
          z = 0.1,
        },
      },
    },

    {
      components = {
        transform = {
          transform = {0, 0.4, -0.5 * math.pi},
        },

        bone = {},
        parentConstraint = {},
      },

      children = {
        {
          components = {
            transform = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 7, 3},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "carnelia/resources/images/farmer/lowerArm.png",
              z = 0.1,
            },
          },
        },

        {
          components = {
            hand = {},

            transform = {
              transform = {0, 0.4, 0},
            },

            bone = {},
            parentConstraint = {},
          },

          children = {
            {
              components = {
                transform = {
                  transform = {0, 0, 0, 1 / 32, 1 / 32, 4.5, 5},
                },

                bone = {},
                parentConstraint = {},

                sprite = {
                  image = "carnelia/resources/images/farmer/hand.png",
                  z = 0.1,
                },
              },
            },
          },
        },
      },
    },
  },
}
