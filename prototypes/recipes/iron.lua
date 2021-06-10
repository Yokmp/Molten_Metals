data:extend({
-- TODO: balancing, STEEL
-- T1 2:2; T2 2:3; T3 2:4
    -------------------
    -- ORE TO LIQUID --
    -------------------
    {
      type = "recipe",
      name = "molten-iron",
      main_product = "molten-iron",
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
      icon = "__Molten_Metals__/graphics/icons/molten-iron.png",
      icon_size = 64,
      normal = {
				enabled = false,
        energy_required = 1.75,
        ingredients = {
          {type = "item", name = "iron-ore", amount = 2}
        },
        results = {
          {type = "fluid", name = "molten-iron", amount = 20, temperature= 1500},
          {type = "item", name = "slag-stone", amount = 3}
        }
      },
      expensive = {
        enabled = false,
        energy_required = 3.5,
        ingredients = {
          {type = "item", name = "iron-ore", amount = 4}
        },
				results = {
          {type = "fluid", name = "molten-iron", amount = 20, temperature= 1500},
          {type = "item", name = "slag-stone", amount = 3}
        }
      }
    },
		---------------------
		-- LIQUID TO PLATE --
		---------------------
		{
			type = "recipe",
			name = "molten-iron-plate",
			category = "Y_casting",
      subgroup = "raw-material",
      show_amount_in_title = true,
      allow_as_intermediate = false,
      allow_intermediates = false,
      hidden = false,
      hide_from_player_crafting = true,
      always_show_products = true,
      crafting_machine_tint = {
        primary = {r = 249/255, g = 137/255, b = 32/255, a = 0},    -- boiling
        secondary = {r = 230/255, g = 125/255, b = 125/255, a = 0}, -- mask
      	tertiary = {r = 230/255, g = 125/255, b = 125/255, a = 0}   -- window
      },
			icon = "__base__/graphics/icons/iron-plate.png",
			icon_size = 64,
			normal = {
				enabled = false,
				energy_required = 1,
				ingredients = {
          {type = "fluid", name = "molten-iron", amount = 25, temperature= 1500},
          {type = "fluid", name = "water", amount = 40}
				},
				results = {
          {type = "item",  name = "iron-plate", amount = 1},
          {type = "fluid", name = "waste-water", amount = 20}
				}
			},
			expensive = {
				enabled = false,
				energy_required = 1,
        ingredients = {
				  {type = "fluid", name = "molten-iron", amount = 50, temperature= 1500},
				  {type = "fluid", name = "water", amount = 80}
        },
				results = {
					{type = "item",  name = "iron-plate", amount = 1},
          {type = "fluid", name = "waste-water", amount = 40}
				}
			}
		},
})
