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
      gravityY = 34,
    },

    {
      domainType = "input",
      class = "plotfarmer.InputDomain",
    },
  },

  componentManagers = {
    {
      componentType = "foot",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "left",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "plant",
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
      componentType = "wheel",
      class = "heart.CategoryComponentManager",
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
      componentType = "motorJoint",
      class = "heart.physics.MotorJointComponentManager",
    },

    {
      componentType = "revoluteJoint",
      class = "heart.physics.RevoluteJointComponentManager",
    },

    {
      componentType = "wheelJoint",
      class = "heart.physics.WheelJointComponentManager",
    },

    {
      componentType = "groundSensor",
      class = "plotfarmer.GroundSensorComponentManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.SpriteComponentManager",
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
    },

    debugdraw = {
      -- {
      --   class = "heart.physicsFixtureDebugDrawSystem",
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
    },

    fixedupdate = {
      {
        class = "plotfarmer.PlayerInputFixedUpdateSystem",
      },

      {
        class = "plotfarmer.PlantInputFixedUpdateSystem",
      },

      {
        class = "plotfarmer.SeesawFixedUpdateSystem",
      },

      {
        class = "heart.animation.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "heart.physics.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.BodyToBoneFixedUpdateSystem",
      },

      {
        class = "plotfarmer.GroundSensorFixedUpdateSystem",
      },

      {
        class = "plotfarmer.FootFixedUpdateSystem",
      },

      {
        class = "heart.animation.ParentConstraintFixedUpdateSystem",
      },
    },

    mousemoved = {
      {
        class = "plotfarmer.InputMouseMovedSystem",
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
    },

    {
      prototype = "plotfarmer.resources.configs.entities.seesaw",
    },

    {
      prototype = "plotfarmer.resources.configs.entities.player",

      components = {
        transform = {
          transform = {0, -3},
        },
      },
    },
  },
}
