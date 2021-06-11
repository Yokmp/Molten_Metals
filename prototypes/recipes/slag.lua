data:extend({
  -- TODO: balancing, powder to pellet
  -------------------------
  -- SLAG TO LANDFILL T1 --
  -------------------------
  -- {
  --   type = "recipe",
  --   name = "slag-landfill",
  --   category = "crafting",
  --   allow_intermediates = true,
  --   always_show_products = true,
  --   crafting_machine_tint = { primary = {r = 0.9, g = 0.5, b = 0.5, a = 0},   -- boiling
  --                             secondary = {r = 0.9, g = 0.5, b = 0.5, a = 0}, -- mask
  --                             tertiary = {r = 0.9, g = 0.5, b = 0.5, a = 0} },-- window
  --   icon = "__Molten_Metals__/graphics/icons/landfill.png",
  --   icon_size = 32,
  --   enabled = false,
  --   energy_required = 0.5,
  --   ingredients = {
  --     {type = "item", name = "slag-stone", amount = 40}
  --   },
  --   results = {
  --     {type = "item", name = "landfill", amount = 1}
  --   }
  -- },
  ----------------------
  -- SLAG TO BRICK T1 --
  ----------------------
  -- {
  --   type = "recipe",
  --   name = "slag-brick",
  --   category = "smelting",
  --   allow_intermediates = true,
  --   always_show_products = true,
  --   crafting_machine_tint = { primary = {r = 0.9, g = 0.5, b = 0.5, a = 0},   -- boiling
  --                             secondary = {r = 0.9, g = 0.5, b = 0.5, a = 0}, -- mask
  --                             tertiary = {r = 0.9, g = 0.5, b = 0.5, a = 0} },-- window
  --   icon = "__Molten_Metals__/graphics/icons/slag-brick.png",
  --   icon_size = 32,
  --   enabled = false,
  --   energy_required = 3.5,
  --   ingredients = {
  --     {type = "item", name = "slag-stone", amount = 10}
  --   },
  --   results = {
  --     {type = "item", name = "stone-brick", amount = 1}
  --   }

  -- },
  --------------------
  -- SLAG TO POWDER --
  --------------------
  -- {
  --   type = "recipe",
  --   name = "slag-powder",
  --   category = "crafting",
  --   subgroup = "intermediate-product",
  --   hide_from_player_crafting = true,
  --   icon = "__Molten_Metals__/graphics/icons/slag-powder.png",
  --   icon_size = 32,
  --   enabled = false,
  --   energy_required = 2,
  --   ingredients = {
  --     {type = "item", name = "slag-stone", amount = 10}
  --   },
  --   results = {
  --     {type = "item", name = "slag-powder", amount = 1}
  --   }
  -- },
  ----------------------
  -- SLAG TO CONCRETE --
  ----------------------
  {
    type = "recipe",
    name = "slag-stone-concrete",
    icon = "__Molten_Metals__/graphics/icons/slag-concrete.png",
    icon_size = 32,
    category = "crafting-with-fluid",
    energy_required = 1,
    show_amount_in_title = true,
    always_show_products = true,
    hide_from_player_crafting = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    enabled = false,
    ingredients = {
      {type = "item",  name = "slag-stone", amount = 10},
      {type = "item",  name = "iron-stick", amount = 2},
      {type = "fluid", name = "waste-water", amount = 60}
    },
    results = {
      {type = "item", name = "concrete", amount = 10}
    }
  },
  ---------------------
  -- SLAG TO PELLETS --
  ---------------------
  {
    type = "recipe",
    name = "slag-pellet",
    icon = "__Molten_Metals__/graphics/icons/slag-pellet.png",
    icon_size = 32,
    category = "crafting",
    subgroup = "intermediate-product",
    energy_required = 1,
    show_amount_in_title = true,
    always_show_products = true,
    hide_from_player_crafting = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    enabled = false,
    ingredients = {
      {type = "item", name = "slag-powder", amount = 10}
    },
    results = {
      {type = "item", name = "slag-pellet", amount = 2}
    }
  },
  -------------------------
  -- PELLETS TO RARE-ORE --
  -------------------------
  {
    type = "recipe",
    name = "slag-pellet-recycling",
    icon = "__Molten_Metals__/graphics/icons/slag-pellet.png",
    icon_size = 32,
    category = "crafting",
    subgroup = "intermediate-product",
    energy_required = 3,
    show_amount_in_title = true,
    always_show_products = true,
    hide_from_player_crafting = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    ingredients = {
      {type = "item", name = "slag-pellet", amount = 10}
    },
    results = {
      {type = "item", name = "stone",       probability = 1.0, amount_min = 2, amount_max = 4 },
      {type = "item", name = "iron-ore",    probability = 0.2, amount_min = 1, amount_max = 2 },
      {type = "item", name = "copper-ore",  probability = 0.2, amount_min = 1, amount_max = 1 },
      {type = "item", name = "lead-ore",    probability = 0.2, amount_min = 1, amount_max = 3 }
    }
  }
})
