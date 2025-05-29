data:extend({
  {
    type = "assembling-machine",
    name = "greenhouse",
    max_health = 500,
    flags = {"placeable-neutral","player-creation"},
    dying_explosion = "big-explosion",
    collision_box = { { -3.25, -3.25 }, { 3.25, 3.25 } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    module_slots = 3,
    allowed_effects = { "consumption", "speed", "productivity", "pollution" },
    minable = { mining_time = 0.3, result = "greenhouse" },
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = -5 },
      drain = "5kW"
    },
    energy_usage = "145kW",
    ingredient_count = 4,
    crafting_speed = 1,
    crafting_categories = { "R-greenhouse" },
    icon = "__Wood_Gasification_updated__/graphics/greenhouse/greenhouse_icon.png",
    icon_size = 64,
    fluid_boxes_off_when_no_fluid_recipe = false,
    fluid_boxes = {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        volume = 400,
        pipe_connections =
        {
          {
            flow_direction="input-output",
            direction = defines.direction.south,
            position = {0, 3}
          },
          {
            flow_direction="input-output",
            direction = defines.direction.north,
            position = {0, -3}
          },
          {
            flow_direction="input-output",
            direction = defines.direction.east,
            position = {3, 0}
          },
          {
            flow_direction="input-output",
            direction = defines.direction.west,
            position = {-3, 0}
          },
        },
      },
    },
    graphics_set = {
      animation =
      {
        layers = {
          {
              filename = "__Wood_Gasification_updated__/graphics/greenhouse/hr-greenhouse.png",
              width = 512,
              height = 512,
              scale = 0.5,
          },
          {
              filename = "__Wood_Gasification_updated__/graphics/greenhouse/hr-greenhouse-sh.png",
              width = 512,
              height = 512,
              shift = { 0.32, 0 },
              draw_as_shadow = true,
              scale = 0.5,
          },
        },
      },
      working_visualisations = {
        {
          draw_as_light = true,
          animation = {
  
              filename = "__Wood_Gasification_updated__/graphics/greenhouse/hr-greenhouse-light.png",
              width = 512,
              height = 512,
              frame_count = 1,
              repeat_count = 10,
              scale = 0.5,
              animation_speed = 0.35,
          },
        },
        {
          animation = {

              filename = "__Wood_Gasification_updated__/graphics/greenhouse/hr-greenhouse-working.png",
              width = 512,
              height = 512,
              frame_count = 10,
              line_length = 5,
              scale = 0.5,
              animation_speed = 0.35,
          },
        },
      },
    }
  }
  })