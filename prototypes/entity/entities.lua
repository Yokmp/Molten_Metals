local sounds = require("__base__.prototypes.entity.sounds")
data:extend({
  --TODO: balancing
  -----------------
  -- FURNACE T2  --
  -----------------
  {
    type = "assembling-machine",
    name = "basic-smelter",
    icon = "__Molten_Metals__/graphics/icons/basic-smelter.png",
    icon_size = 32, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "steel-furnace"},
    max_health = 300,
    corpse = "steel-furnace-remnants",
    dying_explosion = "steel-furnace-explosion",
    vehicle_impact_sound = sounds.generic_impact,
    -- vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/steel-furnace.ogg",
          volume = 0.46
        }
      },
      max_sounds_per_type = 4,
      audible_distance_modifier = 0.37,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    resistances = {
      {
        type = "fire",
        percent = 100
      }
    },
    collision_box = {{ -0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{ -0.8, -1  }, {0.8, 1  }},
    crafting_categories = {"ymm_smelting"},
    fast_replaceable_group = "furnace",
		crafting_speed = 2,
    source_inventory_size = 1,
    result_inventory_size = 1,
    ingredient_count = 1,
		energy_usage = "90kW",
    energy_source = {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      emissions_per_minute = 4,
      fuel_inventory_size = 1,
      light_flicker =
      {
        color = {0, 0, 0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
      smoke =
      {
        {
          name = "smoke",
          frequency = 10,
          position = {0.7, -1.2},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    -- module_specification = { module_slots = 2 },
    -- allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    animation = {
      layers = {
        {
          filename = "__Molten_Metals__/graphics/basic-smelter/smelter.png",
          priority = "high",
          width = 85,
          height = 87,
          frame_count = 1,
          shift = util.by_pixel(-1.5, 1.5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/basic-smelter/hr-smelter.png",
            priority = "high",
            width = 171,
            height = 171,
            frame_count = 1,
            shift = util.by_pixel(-1.25, 2),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/steel-furnace/steel-furnace-shadow.png",
          priority = "high",
          width = 139,
          height = 43,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(39.5, 11.5),
          hr_version = {
            filename = "__base__/graphics/entity/steel-furnace/hr-steel-furnace-shadow.png",
            priority = "high",
            width = 277,
            height = 85,
            frame_count = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(39.25, 11.25),
            scale = 0.5
          }
        },
      },
    },
    working_visualisations =
    {
      {
        draw_as_light = true,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/steel-furnace/steel-furnace-fire.png",
          priority = "high",
          line_length = 8,
          width = 29,
          height = 40,
          frame_count = 48,
          direction_count = 1,
          shift = util.by_pixel(-0.5, 6),
          hr_version =
          {
            filename = "__base__/graphics/entity/steel-furnace/hr-steel-furnace-fire.png",
            priority = "high",
            line_length = 8,
            width = 57,
            height = 81,
            frame_count = 48,
            direction_count = 1,
            shift = util.by_pixel(-0.75, 5.75),
            scale = 0.5
          }
        },
      },
      {
        fadeout = true,
        draw_as_light = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/steel-furnace/steel-furnace-glow.png",
          priority = "high",
          width = 60,
          height = 43,
          frame_count = 1,
          shift = {0.03125, 0.640625},
          blend_mode = "additive"
        }
      },
      {
        fadeout = true,
        draw_as_light = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/steel-furnace/steel-furnace-working.png",
          priority = "high",
          line_length = 1,
          width = 64,
          height = 74,
          frame_count = 1,
          direction_count = 1,
          shift = util.by_pixel(0, -4),
          blend_mode = "additive",
          hr_version =
          {
            filename = "__base__/graphics/entity/steel-furnace/hr-steel-furnace-working.png",
            priority = "high",
            line_length = 1,
            width = 128,
            height = 150,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(0, -5),
            blend_mode = "additive",
            scale = 0.5,
          }
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/steel-furnace/steel-furnace-ground-light.png",
          priority = "high",
          line_length = 1,
          draw_as_sprite = false,
          width = 78,
          height = 64,
          frame_count = 1,
          direction_count = 1,
          shift = util.by_pixel(0, 48),
          blend_mode = "additive",
          hr_version =
          {
            filename = "__base__/graphics/entity/steel-furnace/hr-steel-furnace-ground-light.png",
            priority = "high",
            line_length = 1,
            draw_as_sprite = false,
            width = 152,
            height = 126,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(1, 48),
            blend_mode = "additive",
            scale = 0.5,
          }
        },
      },
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/steel-furnace/steel-furnace-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 24,
        shift = util.by_pixel(0, 45),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    },
    fluid_boxes = {
      {
        production_type = "output",
        minimum_temperature = 1100.0, -- min iron
  			maximum_temperature = 2600.0, -- max copper
        pipe_covers = pipecoverspictures(),
        pipe_picture = assembler1pipepictures(),
        base_area = 2, -- 1 = 100
        base_level = 1,
        pipe_connections =
        {
          { position = { -0.5, -1.5} }
        }
      }
    }
  },
  ----------------
  -- FURNACE T3 --
  ----------------
  {
    type = "assembling-machine",
    name = "advanced-smelter",
    icon = "__base__/graphics/icons/electric-furnace.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "electric-furnace"},
    max_health = 350,
    corpse = "electric-furnace-remnants",
    dying_explosion = "electric-furnace-explosion",
    -- vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    resistances = {
      {
        type = "fire",
        percent = 80
      }
    },
    collision_box = {{ - 1.2, - 1.2}, {1.2, 1.2}},
    selection_box = {{ - 1.5, - 1.5}, {1.5, 1.5}},
    module_specification = { module_slots = 2, module_info_icon_shift = {0, 0.8} },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    crafting_categories = {"ymm_smelting"},
    fast_replaceable_group = "furnace",
    crafting_speed = 2,
    source_inventory_size = 1,
    result_inventory_size = 1,
    ingredient_count = 1,
    energy_usage = "180kW",
		energy_source = {
			type = "electric",
			usage_priority = "secondary-input",
			emissions = 0.03 / 3.5,
			smoke =	{
				{
					name = "smoke",
					frequency = 10,
					position = {0.7, - 1.2},
					starting_vertical_speed = 0.08,
					starting_frame_deviation = 60
				}
			}
		},
    working_sound = {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.6
      },
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    animation = {
      layers = {
        {
          filename = "__Molten_Metals__/graphics/advanced-smelter/advanced-smelter.png",
          priority = "high",
          width = 129,
          height = 100,
          frame_count = 1,
          shift = {0.421875, 0},
          hr_version = {
            filename = "__Molten_Metals__/graphics/advanced-smelter/hr-advanced-smelter.png",
            priority = "high",
            width = 239,
            height = 219,
            frame_count = 1,
            shift = util.by_pixel(0.75, 5.75),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
          priority = "high",
          width = 129,
          height = 100,
          frame_count = 1,
          shift = {0.421875, 0},
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-shadow.png",
            priority = "high",
            width = 227,
            height = 171,
            frame_count = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(11.25, 7.75),
            scale = 0.5
          }
        }
      }
    },
    working_visualisations =
    {
      {
        draw_as_light = true,
        fadeout = true,
        animation =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/electric-furnace/advanced-smelter-heater.png",
              priority = "high",
              width = 25,
              height = 15,
              frame_count = 12,
              animation_speed = 0.5,
              shift = {0.015625, 0.890625},
              hr_version =
              {
                filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-heater.png",
                priority = "high",
                width = 60,
                height = 56,
                frame_count = 12,
                animation_speed = 0.5,
                shift = util.by_pixel(1.75, 32.75),
                scale = 0.5
              }
            },
            {
              filename = "__base__/graphics/entity/electric-furnace/electric-furnace-light.png",
              blend_mode = "additive",
              width = 104,
              height = 102,
              repeat_count = 12,
              shift = util.by_pixel(0, 0),
              hr_version =
              {
                filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-light.png",
                blend_mode = "additive",
                width = 202,
                height = 202,
                repeat_count = 12,
                shift = util.by_pixel(1, 0),
                scale = 0.5,
              }
            },
          }
        },
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        animation =
        {
          filename = "__base__/graphics/entity/electric-furnace/electric-furnace-ground-light.png",
          blend_mode = "additive",
          width = 82,
          height = 64,
          shift = util.by_pixel(4, 68),
          hr_version =
          {
            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-ground-light.png",
            blend_mode = "additive",
            width = 166,
            height = 124,
            shift = util.by_pixel(3, 69),
            scale = 0.5,
          }
        },
      },
      {
        animation =
        {
          filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
          priority = "high",
          width = 19,
          height = 13,
          frame_count = 4,
          animation_speed = 0.5,
          shift = {-0.671875, -0.640625},
          hr_version =
          {
            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-1.png",
            priority = "high",
            width = 37,
            height = 25,
            frame_count = 4,
            animation_speed = 0.5,
            shift = util.by_pixel(-20.5, -18.5),
            scale = 0.5
          }
        }
      },
      {
        animation =
        {
          filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
          priority = "high",
          width = 12,
          height = 9,
          frame_count = 4,
          animation_speed = 0.5,
          shift = {0.0625, -1.234375},
          hr_version =
          {
            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-2.png",
            priority = "high",
            width = 23,
            height = 15,
            frame_count = 4,
            animation_speed = 0.5,
            shift = util.by_pixel(3.5, -38),
            scale = 0.5
          }
        }
      }
    },
		fluid_boxes = {
      {
        production_type = "output",
        minimum_temperature = 1100.0, -- min iron
  			maximum_temperature = 2600.0, -- max copper
        pipe_covers = pipecoverspictures(),
        pipe_picture = assembler1pipepictures(),
        base_level = 1,
        pipe_connections =
        {
          { position = { 0, -2} }
        }
      }
    }
  },
  ------------------------
  -- CASTING MACHINE T1 --
  ------------------------
  {
    type = "assembling-machine",
    name = "basic-caster",
    icon = "__Molten_Metals__/graphics/icons/basic-caster.png",
    icon_size = 32, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    crafting_categories = {"ymm_casting"},
    fast_replaceable_group = "assembling-machine",
    minable = {mining_time = 0.5, result = "basic-caster"},
    max_health = 300,
    corpse = "chemical-plant-remnants",
    dying_explosion = "chemical-plant-explosion",
    -- corpse = "big-remnants",
    -- dying_explosion = "medium-explosion",
    crafting_speed = 1,
    ingredient_count = 1,
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    collision_box = {{ - 1.2, - 1.2}, {1.2, 1.2}},
    selection_box = {{ - 1.5, - 1.5}, {1.5, 1.5}},
    drawing_box = {{ - 1.5, - 1.9}, {1.5, 1.5}},
    energy_usage = "160kW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.03 / 3.5,
      smoke = {
        {
          name = "smoke",
          frequency = 10,
          position = {0.7, - 1.2},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    module_specification = { module_slots = 1 },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    animation = make_4way_animation_from_spritesheet({
      layers = {
      {
        filename = "__Molten_Metals__/graphics/caster/basic-caster.png",
        width = 122,
        height = 134,
        frame_count = 1,
        shift = util.by_pixel(-5, - 4.5),
        hr_version = {
          filename = "__Molten_Metals__/graphics/caster/hr-basic-caster.png",
          width = 244,
          height = 268,
          frame_count = 1,
          shift = util.by_pixel(-5, - 4.5),
          scale = 0.5
        }
      },
      {
        filename = "__Molten_Metals__/graphics/caster/caster-shadow.png",
        width = 175,
        height = 110,
        frame_count = 1,
        shift = util.by_pixel(31.5, 11),
        draw_as_shadow = true,
        hr_version = {
          filename = "__Molten_Metals__/graphics/caster/hr-caster-shadow.png",
          width = 350,
          height = 219,
          frame_count = 1,
          shift = util.by_pixel(31.5, 10.75),
          draw_as_shadow = true,
          scale = 0.5
        }
      }}
  	}),
  	working_visualisations = {
      {
        north_position = util.by_pixel(30, - 24),
        west_position = util.by_pixel(1, - 49.5),
        south_position = util.by_pixel(-30, - 48),
        east_position = util.by_pixel(-11, - 1),
        apply_recipe_tint = "primary",
        animation = {
          filename = "__Molten_Metals__/graphics/caster/boiling-green-patch.png",
          frame_count = 32,
          width = 15,
          height = 10,
          animation_speed = 0.5,
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-green-patch.png",
            frame_count = 32,
            width = 30,
            height = 20,
            animation_speed = 0.5,
            scale = 0.5
          }
        }
      },
      {
        north_position = util.by_pixel(30, - 24),
        west_position = util.by_pixel(1, - 49.5),
        south_position = util.by_pixel(-30, - 48),
        east_position = util.by_pixel(-11, - 1),
        apply_recipe_tint = "secondary",
        animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-green-patch-mask.png",
          frame_count = 32,
          width = 15,
          height = 10,
          animation_speed = 0.5,
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-green-patch-mask.png",
            frame_count = 32,
            width = 30,
            height = 20,
            animation_speed = 0.5,
            scale = 0.5
          }
        }
      },
      {
        apply_recipe_tint = "tertiary",
        north_position = {0, 0},
        west_position = {0, 0},
        south_position = {0, 0},
        east_position = {0, 0},
        north_animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-window-green-patch.png",
          frame_count = 1,
          width = 87,
          height = 60,
          shift = util.by_pixel(0, - 5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-window-green-patch.png",
            x = 0,
            frame_count = 1,
            width = 174,
            height = 119,
            shift = util.by_pixel(0, - 5.25),
            scale = 0.5
          }
        },
        east_animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-window-green-patch.png",
          x = 87,
          frame_count = 1,
          width = 87,
          height = 60,
          shift = util.by_pixel(0, - 5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-window-green-patch.png",
            x = 174,
            frame_count = 1,
            width = 174,
            height = 119,
            shift = util.by_pixel(0, - 5.25),
            scale = 0.5
          }
        },
        south_animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-window-green-patch.png",
          x = 174,
          frame_count = 1,
          width = 87,
          height = 60,
          shift = util.by_pixel(0, - 5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-window-green-patch.png",
            x = 348,
            frame_count = 1,
            width = 174,
            height = 119,
            shift = util.by_pixel(0, - 5.25),
            scale = 0.5
          }
        }
      }
    },
    working_sound = {
      sound = { {
        filename = "__base__/sound/chemical-plant.ogg",
        volume = 0.8
      } },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    -- target_temperature = 500,
  	fluid_boxes = {
  		{ -- back top METAL
  			production_type = "input",
  			minimum_temperature = 1100.0, -- min iron
  			maximum_temperature = 2600.0, -- max copper
  			pipe_covers = pipecoverspictures(),
  			base_area = 2,
  			base_level = -1,
  			pipe_connections = {
  				{
  					type = "input",
  					position = { -1, -2}
  				}
  			}
  		},
  		{ --back bottom WATER
  			production_type = "input",
  			-- filter = "water",
        maximum_temperature = 100.0,
  			pipe_covers = pipecoverspictures(),
  			base_area = 2,
  			base_level = -1,
  			pipe_connections = {
  				{
  					type = "input",
  					position = { 1, -2}
  				}
  			}
  		},
  		{ --back bottom WATER
  			production_type = "output",
        maximum_temperature = 166.0,
  			-- filter = "waste-water",
  			pipe_covers = pipecoverspictures(),
  			base_level = 1,
  			pipe_connections = {
  				{
  					type = "output",
  					position = { -1, 2}
  				}
  			}
  		}
  	}
  },
------------------------
-- CASTING MACHINE T2 --
------------------------
  {
    type = "assembling-machine",
    name = "advanced-caster",
    icon = "__Molten_Metals__/graphics/icons/advanced-caster.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "advanced-caster"},
    crafting_speed = 1.5,
    ingredient_count = 1,
    max_health = 300,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{ - 1.2, - 1.2}, {1.2, 1.2}},
    selection_box = {{ - 1.5, - 1.5}, {1.5, 1.5}},
    drawing_box = {{ - 1.5, - 1.9}, {1.5, 1.5}},
    energy_usage = "220kW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.03 / 3.5,
      smoke = {
        {
          name = "smoke",
          frequency = 10,
          position = {0.7, - 1.2},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    module_specification = { module_slots = 2 },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    crafting_categories = {"ymm_casting"},
    fast_replaceable_group = "assembling-machine",
    animation = make_4way_animation_from_spritesheet({
      layers = {
        {
          filename = "__Molten_Metals__/graphics/caster/advanced-caster.png",
          width = 122,
          height = 134,
          frame_count = 1,
          shift = util.by_pixel(-5, - 4.5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-advanced-caster.png",
            width = 244,
            height = 268,
            frame_count = 1,
            shift = util.by_pixel(-5, - 4.5),
            scale = 0.5
          }
        },
        {
          filename = "__Molten_Metals__/graphics/caster/caster-shadow.png",
          width = 175,
          height = 110,
          frame_count = 1,
          shift = util.by_pixel(31.5, 11),
          draw_as_shadow = true,
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-caster-shadow.png",
            width = 350,
            height = 219,
            frame_count = 1,
            shift = util.by_pixel(31.5, 10.75),
            draw_as_shadow = true,
            scale = 0.5
          }
        },
      }
    }),
    working_visualisations = {
      {
        north_position = util.by_pixel(30, - 24),
        west_position = util.by_pixel(1, - 49.5),
        south_position = util.by_pixel(-30, - 48),
        east_position = util.by_pixel(-11, - 1),
        apply_recipe_tint = "primary",
        animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-green-patch.png",
          frame_count = 32,
          width = 15,
          height = 10,
          animation_speed = 0.5,
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-green-patch.png",
            frame_count = 32,
            width = 30,
            height = 20,
            animation_speed = 0.5,
            scale = 0.5
          }
        }
      },
      {
        north_position = util.by_pixel(30, - 24),
        west_position = util.by_pixel(1, - 49.5),
        south_position = util.by_pixel(-30, - 48),
        east_position = util.by_pixel(-11, - 1),
        apply_recipe_tint = "secondary",
        animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-green-patch-mask.png",
          frame_count = 32,
          width = 15,
          height = 10,
          animation_speed = 0.5,
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-green-patch-mask.png",
            frame_count = 32,
            width = 30,
            height = 20,
            animation_speed = 0.5,
            scale = 0.5
          }
        }
      },
      {
        apply_recipe_tint = "tertiary",
        north_position = {0, 0},
        west_position = {0, 0},
        south_position = {0, 0},
        east_position = {0, 0},
        north_animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-window-green-patch.png",
          frame_count = 1,
          width = 87,
          height = 60,
          shift = util.by_pixel(0, - 5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-window-green-patch.png",
            x = 0,
            frame_count = 1,
            width = 174,
            height = 119,
            shift = util.by_pixel(0, - 5.25),
            scale = 0.5
          }
        },
        east_animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-window-green-patch.png",
          x = 87,
          frame_count = 1,
          width = 87,
          height = 60,
          shift = util.by_pixel(0, - 5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-window-green-patch.png",
            x = 174,
            frame_count = 1,
            width = 174,
            height = 119,
            shift = util.by_pixel(0, - 5.25),
            scale = 0.5
          }
        },
        south_animation =
        {
          filename = "__Molten_Metals__/graphics/caster/boiling-window-green-patch.png",
          x = 174,
          frame_count = 1,
          width = 87,
          height = 60,
          shift = util.by_pixel(0, - 5),
          hr_version = {
            filename = "__Molten_Metals__/graphics/caster/hr-boiling-window-green-patch.png",
            x = 348,
            frame_count = 1,
            width = 174,
            height = 119,
            shift = util.by_pixel(0, - 5.25),
            scale = 0.5
          }
        }
      }
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      sound = { {
        filename = "__base__/sound/chemical-plant.ogg",
        volume = 0.8
      } },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    -- target_temperature = 500,
  	fluid_boxes = {
  		{ -- back top METAL
  			production_type = "input",
  			minimum_temperature = 1100.0, -- min iron
  			maximum_temperature = 2600.0, -- max copper
  			pipe_covers = pipecoverspictures(),
  			base_area = 1,
  			base_level = -1,
  			pipe_connections = {
  				{
  					type = "input",
  					position = { -1, -2}
  				}
  			}
  		},
  		{ --back bottom WATER
  			production_type = "input",
  			-- filter = "water",
  			pipe_covers = pipecoverspictures(),
  			base_area = 1,
  			base_level = -1,
  			pipe_connections = {
  				{
  					type = "input",
  					position = { 1, -2}
  				}
  			}
  		},
  		{ --back bottom WATER
  			production_type = "output",
  			-- filter = "waste-water",
  			pipe_covers = pipecoverspictures(),
  			base_level = 1,
  			pipe_connections = {
  				{
  					type = "output",
  					position = { -1, 2}
  				}
  			}
  		}
  	}
  },
})
