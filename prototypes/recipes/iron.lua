local yutil = require("prototypes.util")

data:extend({
-- TODO: balancing, STEEL
-- T1 2:2; T2 2:3; T3 2:4
  -------------------
  -- ORE TO LIQUID --
  -------------------
  {
    type = "recipe",
    name = "molten-iron",
    category = "ymm_smelting",
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    show_amount_in_title = true,
    always_show_products = true,
    crafting_machine_tint = yutil.color.moltenmetal.tint,
    normal = {
      main_product = "molten-iron",
      enabled = false,
      energy_required = 3.2,  -- vanilla 3.2 at speed 2
      ingredients = {         -- smelterSpeed is 2 and uses 2 ore for molten-iron worth 2 plate -> 1 smelter for 2 casters
        {type = "item", name = "iron-ore", amount = 2}
      },
      results = {
        {type = "fluid", name = "molten-iron", amount = 40, temperature = 1500},
        {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
      }
    },
    expensive = {
      main_product = "molten-iron",
      enabled = false,
      energy_required = 3.2,
      ingredients = {
        {type = "item", name = "iron-ore", amount = 2}
      },
      results = {
        {type = "fluid", name = "molten-iron", amount = 40, temperature = 1500},
        {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}
      }
    }
  },
  ---------------------
  -- LIQUID TO PLATE --
  ---------------------
  {
    type = "recipe",
    name = "molten-iron-plate",
    category = "ymm_casting",
    show_amount_in_title = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    always_show_products = true,
    crafting_machine_tint = yutil.color.moltenmetal.tint,
    normal = {
      main_product = "iron-plate",
      enabled = false,
      energy_required = 1.6, -- 3.2 at speed 2
      ingredients = {
        {type = "fluid", name = "molten-iron", amount = 20, temperature = 1500},
        {type = "fluid", name = "water", amount = 40}
      },
      results = {
        {type = "item",  name = "iron-plate", amount = 1},
        {type = "fluid", name = "steam", amount = 5, temperature = 165}
      }
    },
    expensive = {
      main_product = "iron-plate",
      enabled = false,
      energy_required = 1.6,
      ingredients = {
        {type = "fluid", name = "molten-iron", amount = 20, temperature = 1500},
        {type = "fluid", name = "water", amount = 80}
      },
      results = {
        {type = "item",  name = "iron-plate", amount = 1},
        {type = "fluid", name = "steam", amount = 5, temperature = 165}
      }
    }
  },
})
