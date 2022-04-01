data:extend({
  ----------
  -- ITEM --
  ----------
  {
    type = "item",
    name = "slag-stone",
    icons = {icons:get("slag")},
    subgroup = "terrain",
    order = "f[copper-ore]",
    stack_size = 100
  },
  -- {
  --   type = "item",
  --   name = "slag-powder",
    -- icons = icons:get("powder"),
  --   subgroup = "intermediate-product",
  --   order = "c[iron-gear-wheel]",
  --   stack_size = 200
  -- },
  {
    type = "item",
    name = "slag-pellet",
    icons = {icons:get("pellet")},
    subgroup = "intermediate-product",
    order = "c[iron-gear-wheel]",
    stack_size = 200
  },
--#region unused
  --//TODO: balancing, powder to pellet
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
  --   icons = icons:get("brick"),
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
  --   icons = icons:get("powder"),
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
  -- {
  --   type = "recipe",
  --   name = "slag-stone-concrete",
    -- icons = icons:get("concrete"),
  --   category = "crafting-with-fluid",
  --   energy_required = 1,
  --   show_amount_in_title = true,
  --   always_show_products = true,
  --   hide_from_player_crafting = true,
  --   allow_as_intermediate = false,
  --   allow_intermediates = false,
  --   hidden = false,
  --   enabled = false,
  --   ingredients = {
  --     {type = "item",  name = "slag-stone", amount = 10},
  --     {type = "item",  name = "iron-stick", amount = 2},
  --     {type = "fluid", name = "acidic-water", amount = 60}
  --   },
  --   results = {
  --     {type = "item", name = "concrete", amount = 10}
  --   }
  -- },
--#endregion unused
  -------------
  -- RECIPES --
  -------------
  {
    type = "recipe",
    name = "slag-pellet",
    icons = {icons:get("pellet")},
    category = "crafting",
    subgroup = "intermediate-product",
    energy_required = 1,
    show_amount_in_title = true,
    always_show_products = false,
    hide_from_player_crafting = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    enabled = false,
    crafting_machine_tint = yutil.color.wastewater.tint,
    ingredients = {
      {type = "item", name = "slag-stone", amount = 10}
    },
    results = {
      {type = "item", name = "slag-pellet", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "slag-pellet-recycling",
    icons = {
      icons:get("pellet", 1, {0, -3}),
      icons:get("filter", 0.5, {7,  8}),
      {
        icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
        icon_size = 64,
        icon_mipmaps=4,
        scale = 0.3,
        shift = {7, -6}
      },
    },
    category = "chemistry",
    subgroup = "intermediate-product",
    energy_required = 3,
    show_amount_in_title = true,
    always_show_products = true,
    hide_from_player_crafting = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    enabled = false,
    crafting_machine_tint = yutil.color.wastewater.tint,
    ingredients = {
      {type = "item", name = "slag-pellet", amount = 15},
      {type = "fluid", name = "sulfuric-acid", amount = 35}
    },
    results = {
      -- {type = "item", name = "stone",       probability = 1, amount_min = 1, amount_max = 1 },
      -- {type = "item", name = "iron-ore",    probability = 1/3, amount_min = 1, amount_max = 1 },
      -- {type = "item", name = "copper-ore",  probability = 1/3, amount_min = 1, amount_max = 1 },
    }
  }
})

local results = {}
local ores = get_minable_resouces()
local size = 0
for _ in pairs(ores) do size = size + 1 end
for key, _ in pairs(ores) do
  if key == "stone" then
    table.insert(results, {type = "item", name = key,  probability = 1, amount_min = 1, amount_max = 1 })
  else
    table.insert(results, {type = "item", name = key,  probability = 1/size, amount_min = 1, amount_max = 1 })
  end
end
-- table.insert(data.raw.recipe["slag-pellet-recycling"].ingredients, {type = "item", name = "slag-pellet", amount = 2*size})
data.raw.recipe["slag-pellet-recycling"].results = results
