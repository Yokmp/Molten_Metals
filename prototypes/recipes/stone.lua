local yutil = require("prototypes.util")

data:extend({
-- TODO: balancing
-- T1 2:2; T2 2:3; T3 2:4
    ----------------------------
    -- ORE TO LIQUID T1 BASIC --
    ----------------------------
    {
      type = "recipe",
      name = "molten-stone",
      category = "ymm_smelting",
      allow_as_intermediate = false,
      allow_intermediates = false,
      hidden = false,
      hide_from_player_crafting = true,
      show_amount_in_title = true,
      always_show_products = true,
      order = "m[molten-stone]",
      crafting_machine_tint = yutil.color.moltenmetal.tint,
      normal = {
      main_product = "molten-stone",
				enabled = false,
        energy_required = 3.2,
        ingredients = {
          {type = "item", name = "stone", amount = 2}
        },
        results = {
          {type = "fluid", name = "molten-stone", amount = 40, temperature = yutil.temperatures.stone[1]},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
        }
      },
      expensive = {
        main_product = "molten-stone",
        enabled = false,
        energy_required = 3.2,
        ingredients = {
          {type = "item", name = "stone", amount = 2}
        },
				results = {
          {type = "fluid", name = "molten-stone", amount = 40, temperature = yutil.temperatures.stone[1]},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
        }
      }
    },
		---------------------
		-- LIQUID TO PLATE --
		---------------------
		{
			type = "recipe",
			name = "molten-stone-brick",
			category = "ymm_casting",
      allow_as_intermediate = false,
      allow_intermediates = false,
      always_show_products = true,
      order = "m[molten-stone-brick]",
      crafting_machine_tint = yutil.color.moltenmetal.tint,
			normal = {
        main_product = "stone-brick",
				enabled = false,
				energy_required = 1.6,
				ingredients = {
          {type = "fluid", name = "molten-stone", amount = 20, temperature = yutil.temperatures.stone[1]},
          {type = "fluid", name = "water", amount = 40}
				},
				results = {
          {type = "item",  name = "stone-brick", amount = 1},
          {type = "fluid", name = "steam", amount = 5, temperature = 165}
				}
			},
			expensive = {
        main_product = "stone-brick",
				enabled = false,
				energy_required = 1.6,
        ingredients = {
				  {type = "fluid", name = "molten-stone", amount = 20, temperature = yutil.temperatures.stone[1]},
				  {type = "fluid", name = "water", amount = 80}
        },
				results = {
					{type = "item", name = "stone-brick", amount = 1},
          {type = "fluid", name = "steam", amount = 5, temperature = 165}
				}
			}
		},
})
