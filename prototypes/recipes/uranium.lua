local yutil = require("prototypes.util")

data:extend({
  {
    type = "recipe",
    name = "molten-uranium",
    category = "ymm_smelting",
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    show_amount_in_title = true,
    always_show_products = true,
    order = "m[molten-uranium]",
    crafting_machine_tint = yutil.color.moltenmetal.tint,
    normal = {
      main_product = "molten-uranium",
      enabled = false,
      energy_required = 3.2,
      ingredients = {
        {type = "item", name = "uranium-ore", amount = 2}
      },
      results = {
        {type = "fluid", name = "molten-uranium", amount = 40, temperature = yutil.temperatures.uranium[1],},
        {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
      }
    },
    expensive = {
      main_product = "molten-uranium",
      enabled = false,
      energy_required = 3.2,
      ingredients = {
        {type = "item", name = "uranium-ore", amount = 2}
      },
      results = {
        {type = "fluid", name = "molten-uranium", amount = 40, temperature = yutil.temperatures.uranium[1]},
        {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
      }
    },
  },
  {
    type = "recipe",
    name = "molten-uranium-processing",
    enabled = false,
    main_product = "uranium-235",
    category = "ymm_casting",
    allow_as_intermediate = false, -- can be used in handcrafting?
    allow_intermediates = false,  -- can be handcrafted?
    hidden = false,
    hide_from_player_crafting = true, -- hidden in player screen?
    always_show_products = true,
    show_amount_in_title = true,
    crafting_machine_tint = yutil.color.moltenmetal.tint,
    ingredients = {
      {type = "fluid", name = "molten-uranium", amount = 200, temperature = yutil.temperatures.uranium[1]},
      {type = "fluid", name = "water", amount = 400}
    },
    results = {
      {type = "item", name = "uranium-238", amount = 1, probability = 0.993},
      {type = "item", name = "uranium-235", amount = 1, probability = 0.007},
      {type = "fluid", name = "steam", amount = 200, temperature = 165}
    },
  },
})
