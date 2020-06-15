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
      class = "carnelia.SpriteComponentManager",
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
        class = "carnelia.SkyDrawSystem",
      },

      {
        class = "heart.graphics.ViewportDrawSystem",
      },

      {
        class = "carnelia.FpsDrawSystem",
      },
    },

    drawworld = {
      {
        class = "carnelia.SpriteDrawWorldSystem",
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
        bounds = {-20, -10, 20, 10},
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
}
