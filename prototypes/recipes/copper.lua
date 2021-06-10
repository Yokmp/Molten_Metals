data:extend({
-- TODO: balancing
-- T1 2:2; T2 2:3; T3 2:4
    ----------------------------
    -- ORE TO LIQUID T1 BASIC --
    ----------------------------
    {
      type = "recipe",
      name = "molten-copper",
      category = "Y_smelting",
      subgroup = "raw-material",
      allow_as_intermediate = false,
      allow_intermediates = false,
      hidden = false,
      hide_from_player_crafting = true,
      show_amount_in_title = true,
      always_show_products = true,
      crafting_machine_tint = {
        primary = {r = 249/255, g = 137/255, b = 32/255, a = 0},    -- boiling
        secondary = {r = 230/255, g = 125/255, b = 125/255, a = 0}, -- mask
      	tertiary = {r = 230/255, g = 125/255, b = 125/255, a = 0}   -- window
      },
      icon = "__Molten_Metals__/graphics/icons/molten-copper.png",
      icon_size = 64,
      normal = {
				enabled = false,
        energy_required = 1.75,
        ingredients = {
          {type = "item", name = "copper-ore", amount = 2}
        },
        results = {
          {type = "fluid", name = "molten-copper", amount = 20, temperature= 1100},
          {type = "item", name = "slag-stone", amount = 3}
        }
      },
      expensive = {
        enabled = false,
        energy_required = 3.5,
        ingredients = {
          {type = "item", name = "copper-ore", amount = 4}
        },
				results = {
          {type = "fluid", name = "molten-copper", amount = 20, temperature= 1100},
          {type = "item", name = "slag-stone", amount = 3}
        }
      }
    },
		---------------------
		-- LIQUID TO PLATE --
		---------------------
		{
			type = "recipe",
			name = "molten-copper-plate",
			category = "Y_casting",
      subgroup = "raw-material",
      allow_as_intermediate = false,
      allow_intermediates = false,
      always_show_products = true,
      crafting_machine_tint = {
        primary = {r = 249/255, g = 137/255, b = 32/255, a = 0},    -- boiling
        secondary = {r = 230/255, g = 125/255, b = 125/255, a = 0}, -- mask
      	tertiary = {r = 230/255, g = 125/255, b = 125/255, a = 0}   -- window
      },
			icon = "__base__/graphics/icons/copper-plate.png",
			icon_size = 64,
			normal = {
				enabled = false,
				energy_required = 0.8,
				ingredients = {
          {type = "fluid", name = "molten-copper", amount = 25, temperature= 1100},
          {type = "fluid", name = "water", amount = 40}
				},
				results = {
          {type = "item",  name = "copper-plate", amount = 1},
          {type = "fluid", name = "waste-water", amount = 20}
				}
			},
			expensive = {
				enabled = false,
				energy_required = 0.8,
        ingredients = {
				  {type = "fluid", name = "molten-copper", amount = 50, temperature= 1100},
				  {type = "fluid", name = "water", amount = 80}
        },
				results = {
					{type = "item", name = "copper-plate", amount = 1},
          {type = "fluid", name = "waste-water", amount = 40}
				}
			}
		},
})
