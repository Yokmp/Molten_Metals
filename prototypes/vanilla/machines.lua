--//TODO FLUID MIXER

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
    name = "fluid-mixer",
    energy_required = 2,
    enabled = false,
    ingredients = {
      {"engine-unit", 1},
      {"iron-plate", 4},
      {"pipe", 2}
    },
    result = "fluid-mixer"
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
    icons = {icons:get("basic_smelter")},
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
    name = "fluid-mixer",
    icons = {icons:get("missing")}, --//TODO fluid mixer icon
    subgroup = "production-machine",
    order = "d[fluid-mixer]",
    place_result = "fluid-mixer",
    stack_size = 50
  },
  {
    type = "item",
    name = "basic-caster",
    icons = settings.startup["ymm-use-old-icons"].value and {icons:get("basic_old")} or {icons:get("basic_caster")},
    subgroup = "production-machine",
    order = "e[basic-caster]",
    place_result = "basic-caster",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-caster",
    icons = settings.startup["ymm-use-old-icons"].value and {icons:get("advanced_old")} or {icons:get("advanced_caster")},
    subgroup = "production-machine",
    order = "f[advanced-caster]",
    place_result = "advanced-caster",
    stack_size = 50
  },
-----------
-- ICONS --
-----------
  {
    type = "item",
    name = "basic-caster-old",
    icons = {icons:get("basic_old")},
    stack_size = 1,
    flags = { "hidden" }
  },
  {
    type = "item",
    name = "advanced-caster-old",
    icons = {icons:get("advanced_old")},
    stack_size = 1,
    flags = { "hidden" }
  },
})
