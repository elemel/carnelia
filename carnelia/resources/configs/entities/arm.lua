return {
  components = {
    bone = {},

    parentConstraint = {
      enabled = false,
    },
  },

  children = {
    {
      components = {
        bone = {
          transform = {0, 0, 0, 1 / 32, 1 / 32, 6, 3},
        },

        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/farmer/upperArm.png",
        },
      },
    },

    {
      components = {
        bone = {
          transform = {0, 0.4, -0.5 * math.pi},
        },

        parentConstraint = {
          enabled = false,
        },
      },

      children = {
        {
          components = {
            bone = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 7, 3},
            },

            parentConstraint = {},

            sprite = {
              image = "carnelia/resources/images/farmer/lowerArm.png",
            },
          },
        },

        {
          components = {
            hand = {},

            bone = {
              transform = {0, 0.4, 0},
            },

            parentConstraint = {
              enabled = false,
            },
          },

          children = {
            {
              components = {
                bone = {
                  transform = {0, 0, 0, 1 / 32, 1 / 32, 4.5, 5},
                },

                parentConstraint = {},

                sprite = {
                  image = "carnelia/resources/images/farmer/hand.png",
                },
              },
            },
          },
        },
      },
    },
  },
}
