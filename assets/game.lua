return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.Timer",
      fixedDt = 1 / 60,
    },

    {
      domainType = "physics",
      class = "heart.physics.domains.Physics",
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
      class = "plotfarmer.components.GroundSensorManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.components.SpriteManager",
    },
  },

  systems = {
    draw = {
      {
        class = "heart.graphics.systems.draw.DrawViewports",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.systems.drawworld.DrawWorldSprites",
      },
    },

    debugdraw = {
      -- {
      --   class = "heart.physics.systems.debugdraw.DebugDrawPhysics",
      -- },

      -- {
      --   class = "heart.animation.systems.debugdraw.DebugDrawBones",
      --   color = {1, 1, 0, 1},
      --   scale = 0.25,
      -- },

      -- {
      --   class = "heart.animation.systems.debugdraw.DebugDrawParentConstraints",
      --   color = {1, 0.5, 0, 1},
      -- },
    },

    fixedupdate = {
      {
        class = "plotfarmer.systems.fixedUpdate.UpdatePlayerInputs",
      },

      {
        class = "plotfarmer.systems.fixedUpdate.UpdateSeesaws",
      },

      {
        class = "heart.animation.systems.fixedupdate.FixedUpdateBones",
      },

      {
        class = "heart.physics.systems.fixedupdate.FixedUpdateWorld",
      },

      {
        class = "heart.physics.systems.fixedupdate.FixedUpdateBonesFromBodies",
      },

      {
        class = "plotfarmer.systems.fixedUpdate.UpdateGroundSensors",
      },

      {
        class = "plotfarmer.systems.fixedUpdate.UpdateFeet",
      },

      {
        class = "heart.animation.systems.fixedupdate.FixedUpdateParentConstraints",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ResizeViewports",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.UpdateTimer",
      },

      {
        class = "heart.graphics.systems.update.UpdateSpritesFromBones",
      },

      {
        class = "heart.graphics.systems.update.UpdateCamerasFromBones",
      },
    },
  },

  entities = {
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
