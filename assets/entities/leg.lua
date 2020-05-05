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
          transform = {0, 0, 0, 0.025, 0.025, 12.5, 5},
        },

        bone = {},
        parentConstraint = {},

        sprite = {
          image = "assets/images/skins/player/upperLeg.png",
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
              transform = {0, 0, 0, 0.025, 0.025, 12.5, 5},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "assets/images/skins/player/lowerLeg.png",
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
                  transform = {0, 0, 0, 0.025, 0.025, 10, 10},
                },

                bone = {},
                parentConstraint = {},

                sprite = {
                  image = "assets/images/skins/player/foot.png",
                },
              },
            },
          },
        },
      },
    },
  },
}
