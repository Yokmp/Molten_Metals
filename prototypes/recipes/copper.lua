data:extend({
-- TODO: balancing
-- T1 2:2; T2 2:3; T3 2:4
    ----------------------------
    -- ORE TO LIQUID T1 BASIC --
    ----------------------------
    {
      type = "recipe",
      name = "molten-copper",
      category = "ymm_smelting",
      -- subgroup = "raw-material",
      allow_as_intermediate = false,
      allow_intermediates = false,
      hidden = false,
      hide_from_player_crafting = true,
      show_amount_in_title = true,
      always_show_products = true,
      crafting_machine_tint = moltenmetaltint(),
      -- icon = "__Molten_Metals__/graphics/icons/molten-copper.png",
      -- icon_size = 64,
      normal = {
      main_product = "molten-copper",
				enabled = false,
        energy_required = 3.2,
        ingredients = {
          {type = "item", name = "copper-ore", amount = 2}
        },
        results = {
          {type = "fluid", name = "molten-copper", amount = 40, temperature = 1100},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
        }
      },
      expensive = {
        main_product = "molten-copper",
        enabled = false,
        energy_required = 3.2,
        ingredients = {
          {type = "item", name = "copper-ore", amount = 2}
        },
				results = {
          {type = "fluid", name = "molten-copper", amount = 40, temperature = 1100},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
        }
      }
    },
		---------------------
		-- LIQUID TO PLATE --
		---------------------
		{
			type = "recipe",
			name = "molten-copper-plate",
			category = "ymm_casting",
      -- subgroup = "raw-material",
      allow_as_intermediate = false,
      allow_intermediates = false,
      always_show_products = true,
      crafting_machine_tint = moltenmetaltint(),
			-- icon = "__base__/graphics/icons/copper-plate.png",
			-- icon_size = 64,
			normal = {
        main_product = "copper-plate",
				enabled = false,
				energy_required = 1.6,
				ingredients = {
          {type = "fluid", name = "molten-copper", amount = 20, temperature = 1100},
          {type = "fluid", name = "water", amount = 40}
				},
				results = {
          {type = "item",  name = "copper-plate", amount = 1},
          {type = "fluid", name = "waste-water", amount = 20}
				}
			},
			expensive = {
        main_product = "copper-plate",
				enabled = false,
				energy_required = 1.6,
        ingredients = {
				  {type = "fluid", name = "molten-copper", amount = 20, temperature = 1100},
				  {type = "fluid", name = "water", amount = 80}
        },
				results = {
					{type = "item", name = "copper-plate", amount = 1},
          {type = "fluid", name = "waste-water", amount = 20}
				}
			}
		},
})
