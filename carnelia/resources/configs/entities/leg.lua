return {
  components = {
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
          transform = {0, 0, 0, 1 / 32, 1 / 32, 6, 3},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "carnelia/resources/images/farmer/upperLeg.png",
        },
      },
    },

    {
      components = {
        transform = {
          transform = {0, 0.5, 0.5 * math.pi},
        },

        bone = {},

        parentConstraint = {
          enabled = false,
        },
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
              image = "carnelia/resources/images/farmer/lowerLeg.png",
            },
          },
        },

        {
          components = {
            foot = {},

            transform = {
              transform = {0, 0.5, -0.25 * math.pi},
            },

            bone = {},

            parentConstraint = {
              enabled = false,
            },
          },

          children = {
            {
              components = {
                transform = {
                  transform = {0, 0, 0, 1 / 32, 1 / 32, 4.75, 7},
                },

                bone = {},
                parentConstraint = {},

                sprite = {
                  image = "carnelia/resources/images/farmer/foot.png",
                },
              },
            },
          },
        },
      },
    },
  },
}
