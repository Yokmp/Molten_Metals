
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
    icons = {ylib.icon.icons:get("Molten_Metals", "basic-smelter")},
    group = "furnace",
    subgroup = "smelting-machine",
    order = "b[basic-smelter]",
    place_result = "basic-smelter",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-smelter",
    icons = {ylib.icon.icons:get("Molten_Metals", "advanced-smelter")},
    group = "furnace",
    subgroup = "smelting-machine",
    order = "c[advanced-smelter]",
    place_result = "advanced-smelter",
    stack_size = 50
  },
  {
    type = "item",
    name = "basic-caster",
    icons = settings.startup["ymm-use-old-icons"].value and {ylib.icon.icons:get("Molten_Metals", "basic-caster-old")} or {ylib.icon.icons:get("Molten_Metals", "basic-caster")},
    subgroup = "production-machine",
    order = "e[basic-caster]",
    place_result = "basic-caster",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-caster",
    icons = settings.startup["ymm-use-old-icons"].value and {ylib.icon.icons:get("Molten_Metals", "advanced-caster-old")} or {ylib.icon.icons:get("Molten_Metals", "advanced-caster")},
    subgroup = "production-machine",
    order = "f[advanced-caster]",
    place_result = "advanced-caster",
    stack_size = 50
  },
  -- {
  --   type = "item",
  --   name = "insulated-pipe",
  --   icons = {ylib.icon.icons:get("Molten_Metals", "pipe")},
  --   subgroup = "energy-pipe-distribution",
  --   order = "a[pipe]-b[insulated-pipe]",
  --   place_result = "insulated-pipe",
  --   stack_size = 100
  -- },
  -- {
  --   type = "item",
  --   name = "insulated-pipe-to-ground",
  --   icons = {ylib.icon.icons:get("Molten_Metals", "pipe_to_ground")},
  --   subgroup = "energy-pipe-distribution",
  --   order = "a[pipe]-c[insulated-pipe-to-ground]",
  --   place_result = "insulated-pipe-to-ground",
  --   stack_size = 50
  -- },
})
