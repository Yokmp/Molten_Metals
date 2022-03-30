data:extend({
  ------------
  -- RECIPE --
  ------------
  {
    type = "recipe",
    name = "basic-smelter",
    energy_required = 3,
    enabled = false,
    ingredients = {
      {"pipe", 10},
      {"stone-brick", 10},
      {"steel-plate", 4}
    },
    result = "basic-smelter"
  },
  {
    type = "recipe",
    name = "advanced-smelter",
    energy_required = 5,
    enabled = false,
    ingredients = {
      -- {"productivity-module-2", 4},
      {"steel-plate", 6},
      {"advanced-circuit", 4},
      {"stone-brick", 10},
      {"pipe", 20}
    },
    result = "advanced-smelter"
  },
  {
    type = "recipe",
    name = "basic-caster",
    energy_required = 3,
    enabled = false,
    ingredients = {
      {"steel-plate", 2},
      {"electronic-circuit", 3},
      {"pipe", 10}
    },
    result = "basic-caster"
  },
  {
    type = "recipe",
    name = "advanced-caster",
    energy_required = 5,
    enabled = false,
    ingredients = {
      {"speed-module", 2},
      {"basic-caster", 1},
      {"pipe", 20}
    },
    result = "advanced-caster"
  },
  -----------
  -- ITEMS --
  -----------
  {
    type = "item",
    name = "basic-smelter",
    icons = {icons:get("basic-smelter")},
    group = "furnace",
    subgroup = "smelting-machine",
    order = "b[basic-smelter]",
    place_result = "basic-smelter",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-smelter",
    icon = "__base__/graphics/icons/electric-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    group = "furnace",
    subgroup = "smelting-machine",
    order = "c[advanced-smelter]",
    place_result = "advanced-smelter",
    stack_size = 50
  },
  {
    type = "item",
    name = "basic-caster",
    icons = {icons:get("basic-caster")},
    subgroup = "production-machine",
    order = "c[basic-caster]",
    place_result = "basic-caster",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-caster",
    icons = {icons:get("advanced-caster")},
    subgroup = "production-machine",
    order = "d[advanced-caster]",
    place_result = "advanced-caster",
    stack_size = 50
  },
-----------
-- ICONS --
-----------
  {
    type = "item",
    name = "basic-caster-old",
    icons = {{icon = "__Molten_Metals__/graphics/icons/basic-caster-old.png",
    icon_size = 32, icon_mipmaps = 4,}},
    stack_size = 1,
    flags = { "hidden" }
  },
  {
    type = "item",
    name = "advanced-caster-old",
    icons = {{icon = "__Molten_Metals__/graphics/icons/advanced-caster-old.png",
    icon_size = 32, icon_mipmaps = 4,}},
    stack_size = 1,
    flags = { "hidden" }
  },
})
