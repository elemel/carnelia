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
          image = "carnelia/resources/images/farmer/upperLeg.png",
          normalMap = "carnelia/resources/images/farmer/upperLegNormal.png",
        },
      },
    },

    {
      components = {
        bone = {
          transform = {0, 0.5, 0.5 * math.pi},
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
              image = "carnelia/resources/images/farmer/lowerLeg.png",
              normalMap = "carnelia/resources/images/farmer/lowerLegNormal.png",
            },
          },
        },

        {
          components = {
            foot = {},

            bone = {
              transform = {0, 0.5, -0.25 * math.pi},
            },

            parentConstraint = {
              enabled = false,
            },
          },

          children = {
            {
              components = {
                bone = {
                  transform = {0, 0, 0, 1 / 32, 1 / 32, 4.75, 7},
                },

                parentConstraint = {},

                sprite = {
                  image = "carnelia/resources/images/farmer/foot.png",
                  normalMap = "carnelia/resources/images/farmer/footNormal.png",
                },
              },
            },
          },
        },
      },
    },
  },
}
