return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.TimerDomain",
      fixedDt = 1 / 60,
    },

    {
      domainType = "physics",
      class = "heart.physics.domains.PhysicsDomain",
      gravityY = 34,
    },
  },

  componentManagers = {
    {
      componentType = "foot",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "left",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "player",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "right",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "seesaw",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "wheel",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "transform",
      class = "heart.animation.components.TransformManager",
    },

    {
      componentType = "bone",
      class = "heart.animation.components.BoneManager",
    },

    {
      componentType = "parentConstraint",
      class = "heart.animation.components.ParentConstraintManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.components.CameraManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.components.ViewportManager",
    },

    {
      componentType = "body",
      class = "heart.physics.components.BodyManager",
    },

    {
      componentType = "chainFixture",
      class = "heart.physics.components.ChainFixtureManager",
    },

    {
      componentType = "circleFixture",
      class = "heart.physics.components.CircleFixtureManager",
    },

    {
      componentType = "polygonFixture",
      class = "heart.physics.components.PolygonFixtureManager",
    },

    {
      componentType = "rectangleFixture",
      class = "heart.physics.components.RectangleFixtureManager",
    },

    {
      componentType = "motorJoint",
      class = "heart.physics.components.MotorJointManager",
    },

    {
      componentType = "revoluteJoint",
      class = "heart.physics.components.RevoluteJointManager",
    },

    {
      componentType = "wheelJoint",
      class = "heart.physics.components.WheelJointManager",
    },

    {
      componentType = "groundSensor",
      class = "components.GroundSensorManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.components.SpriteManager",
    },
  },

  systems = {
    draw = {
      {
        class = "heart.graphics.systems.draw.ViewportDrawSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.systems.drawworld.SpriteDrawWorldSystem",
      },
    },

    debugdraw = {
      -- {
      --   class = "heart.physics.systems.debugdraw.FixtureDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.animation.systems.debugdraw.BoneDebugDrawSystem",
      --   color = {1, 1, 0, 1},
      --   scale = 0.25,
      -- },

      -- {
      --   class = "heart.animation.systems.debugdraw.ParentConstraintDebugDrawSystem",
      --   color = {1, 0.5, 0, 1},
      -- },
    },

    fixedupdate = {
      {
        class = "systems.fixedUpdate.PlayerInputFixedUpdateSystem",
      },

      {
        class = "systems.fixedUpdate.SeesawFixedUpdateSystem",
      },

      {
        class = "heart.animation.systems.fixedupdate.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "heart.physics.systems.fixedupdate.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.systems.fixedupdate.BodyToBoneFixedUpdateSystem",
      },

      {
        class = "systems.fixedUpdate.GroundSensorFixedUpdateSystem",
      },

      {
        class = "systems.fixedUpdate.FootFixedUpdateSystem",
      },

      {
        class = "heart.animation.systems.fixedupdate.ParentConstraintFixedUpdateSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.TimerUpdateSystem",
      },

      {
        class = "heart.graphics.systems.update.SpriteFromBoneUpdateSystem",
      },

      {
        class = "heart.graphics.systems.update.CameraFromBoneUpdateSystem",
      },
    },
  },

  entities = {
    {
      components = {
        transform = {
          transform = {0, 0, 0, 10},
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
      prototype = "assets.entities.seesaw",
    },

    {
      prototype = "assets.entities.player",

      components = {
        transform = {
          transform = {0, -3},
        },
      },
    },
  },
}
