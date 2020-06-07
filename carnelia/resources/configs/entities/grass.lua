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
      componentType = "water",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "wheel",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "characterLowerState",
      class = "heart.StateComponentManager",
      defaultState = "falling",
      validStates = {"falling", "running", "standing", "walking"},
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
      defaultState = "aiming",
      validStates = {"aiming", "swinging", "vaulting"},
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

      {
        class = "carnelia.FpsDrawSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },

      {
        class = "carnelia.StalkDrawWorldSystem",
      },

      {
        class = "carnelia.WaterDrawWorldSystem",
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
        class = "carnelia.WaterFixedUpdateSystem",
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
      prototype = "carnelia.resources.configs.entities.terrain.grass4x2",

      components = {
        transform = {
          transform = {-6.7, 3.7, 0.6},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.terrain.grassTop4x2",

      components = {
        transform = {
          transform = {-0.5, 3.5, 0},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.terrain.grassBottom4x2",

      components = {
        transform = {
          transform = {5, 0, 0},
        },
      },
    },

    {
      prototype = "carnelia.resources.configs.entities.seesaw",
    },

    {
      prototype = "carnelia.resources.configs.entities.farmer",

      components = {
        transform = {
          transform = {-3, -3},
        },
      },
    },

    {
      components = {
        water = {},

        transform = {
          transform = {0, 10},
        },

        body = {},

        rectangleFixture = {
          width = 50,
          height = 5,

          sensor = true,
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-10, 8},
        },

        bone = {},

        body = {
          bodyType = "dynamic",
          linearDamping = 0.5,
          angularDamping = 0.5,
        },

        rectangleFixture = {
          width = 8,
          height  = 1,
        },
      },

      children = {
        {
          components = {
            transform = {
              transform = {0, 0, 0, 1 / 32, 1 / 32, 128, 16},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "carnelia/resources/images/raft.png",
              z = 0.1,
            },
          },
        },
      },
    },
  },
}
