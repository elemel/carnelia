return {
  domains = {
    {
      domainType = "timer",
      class = "heart.TimerDomain",
      fixedDt = 1 / 60,
    },

    {
      domainType = "physics",
      class = "heart.physics.PhysicsDomain",
      gravityY = 10,
    },

    {
      domainType = "input",
      class = "carnelia.InputDomain",
    },
  },

  componentManagers = {
    {
      componentType = "foot",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "hand",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "head",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "jaw",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "left",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "lower",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "player",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "right",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "seesaw",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "upper",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "wheel",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "characterState",
      class = "heart.StateComponentManager",
      defaultState = "falling",
      validStates = {"falling", "running", "standing"},
    },

    {
      componentType = "characterUpperState",
      class = "heart.StateComponentManager",
      defaultState = "aiming",
      validStates = {"aiming", "firing", "swinging", "vaulting"},
    },

    {
      componentType = "plantState",
      class = "heart.StateComponentManager",
      defaultState = "idle",
      validStates = {"grabbing", "idle"},
    },

    {
      componentType = "transform",
      class = "heart.animation.TransformComponentManager",
    },

    {
      componentType = "bone",
      class = "heart.animation.BoneComponentManager",
    },

    {
      componentType = "parentConstraint",
      class = "heart.animation.ParentConstraintComponentManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.CameraComponentManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.ViewportComponentManager",
    },

    {
      componentType = "body",
      class = "heart.physics.BodyComponentManager",
    },

    {
      componentType = "chainFixture",
      class = "heart.physics.ChainFixtureComponentManager",
    },

    {
      componentType = "circleFixture",
      class = "heart.physics.CircleFixtureComponentManager",
    },

    {
      componentType = "polygonFixture",
      class = "heart.physics.PolygonFixtureComponentManager",
    },

    {
      componentType = "rectangleFixture",
      class = "heart.physics.RectangleFixtureComponentManager",
    },

    {
      componentType = "distanceJoint",
      class = "heart.physics.DistanceJointComponentManager",
    },

    {
      componentType = "motorJoint",
      class = "heart.physics.MotorJointComponentManager",
    },

    {
      componentType = "revoluteJoint",
      class = "heart.physics.RevoluteJointComponentManager",
    },

    {
      componentType = "ropeJoint",
      class = "heart.physics.RopeJointComponentManager",
    },

    {
      componentType = "wheelJoint",
      class = "heart.physics.WheelJointComponentManager",
    },

    {
      componentType = "raySensor",
      class = "heart.physics.RaySensorComponentManager",
    },

    {
      componentType = "groundFilter",
      class = "carnelia.GroundFilterComponentManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.SpriteComponentManager",
    },

    {
      componentType = "character",
      class = "carnelia.CharacterComponentManager",
    },

    {
      componentType = "plant",
      class = "carnelia.PlantComponentManager",
    },
  },

  systems = {
    draw = {
      {
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },

      {
        class = "carnelia.StalkDrawWorldSystem",
      },
    },

    debugdraw = {
      -- {
      --   class = "heart.graphics.SpriteDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.physics.FixtureDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.physics.JointDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.animation.BoneDebugDrawSystem",
      --   color = {1, 1, 0, 1},
      --   scale = 0.25,
      -- },

      -- {
      --   class = "heart.animation.ParentConstraintDebugDrawSystem",
      --   color = {1, 0.5, 0, 1},
      -- },

      -- {
      --   class = "heart.physics.RaySensorDebugDrawSystem",
      --   color = {1, 0, 0, 1},
      --   scale = 0.5,
      -- },
    },

    fixedupdate = {
      {
        class = "heart.animation.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "carnelia.SeesawFixedUpdateSystem",
      },

      {
        class = "carnelia.PlayerInputFixedUpdateSystem",
      },

      {
        class = "carnelia.PlantInputFixedUpdateSystem",
      },

      {
        class = "heart.physics.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.BodyToBoneFixedUpdateSystem",
      },

      {
        class = "heart.physics.RaySensorFixedUpdateSystem",
      },

      {
        class = "carnelia.CharacterAnimationFixedUpdateSystem",
      },

      {
        class = "carnelia.PlantAnimationFixedUpdateSystem",
      },

      {
        class = "carnelia.PlayerToCameraUpdateSystem",
        bounds = {-10, -5, 10, 5},
      },

      {
        class = "heart.animation.ParentConstraintFixedUpdateSystem",
      },
    },

    mousemoved = {
      {
        class = "carnelia.InputMouseMovedSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.TimerUpdateSystem",
      },

      {
        class = "heart.graphics.SpriteFromBoneUpdateSystem",
        hardFlipEnabled = true,
      },

      {
        class = "heart.graphics.CameraFromBoneUpdateSystem",
      },
    },
  },

  entities = {
    {
      components = {
        transform = {
          transform = {0, 0, 0, 15},
        },

        bone = {},
        camera = {},
        viewport = {},
      },
    },

    {
      components = {
        transform = {
          transform = {0, 2},
        },

        body = {},

        chainFixture = {
          points = {
            -8, 0.2,
            -7, 0.7,
            -6, 1.2,
            -5, 1.5,
            -4, 1.4,
            -3, 1,
            -2, 0.55,
            -1.5, 0.35,
            -1, 0.25,
            -0.5, 0.2,
            0, 0.3,
            0.5, 0.4,
            1, 0.55,
            2, 0.8,
            3, 1,
            4, 1.2,
            5, 1.1,
            6, 0.8,
            7, 0.3,
            8, -0.3,
          },
        },
      },

      children = {
        {
          components = {
            transform = {
              transform = {-7, 1.5, 0.6, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },

        {
          components = {
            transform = {
              transform = {-5.5, 2.1, 0.2, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },

        {
          components = {
            transform = {
              transform = {-3, 1.7, -0.5, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },

        {
          components = {
            transform = {
              transform = {-0.5, 1, 0, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },

        {
          components = {
            transform = {
              transform = {2, 1.5, 0.2, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },

        {
          components = {
            transform = {
              transform = {4.5, 1.8, -0.1, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },

        {
          components = {
            transform = {
              transform = {7, 1.1, -0.6, 1 / 32, 1 / 32, 64, 32},
            },

            sprite = {
              image = "carnelia/resources/images/grass.png",
              z = -1,
            },
          },
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.seesaw",
    },

    {
      components = {
        transform = {
          transform = {0, -1.25},
        },

        body = {},

        rectangleFixture = {
          height = 2,
          sensor = true,
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.farmer",

      components = {
        transform = {
          transform = {-3, -3},
        },
      },
    },
  },
}
