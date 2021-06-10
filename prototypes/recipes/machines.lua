data:extend({
    ----------------
    -- SMELTER T1 --
    ----------------
  -- {
  --   type = "recipe",
  --   name = "basic-smelter",
  --   energy_required = 3,
  --   enabled = false,
  --   ingredients = {
  --     {"steel-furnace", 1},
  --     {"pipe", 15},
  --     {"stone-brick", 20},
  --     {"steel-plate", 10}
  --   },
  --   result = "steel-furnace"
  -- },
  ------------------
  -- E-SMELTER T3 --
  ------------------
  -- {
  --   type = "recipe",
  --   name = "advanced-smelter",
  --   energy_required = 5,
  --   enabled = false,
  --   ingredients = {
  --     {"productivity-module-2", 4},
  --     {"steel-plate", 30},
  --     {"advanced-circuit", 20},
  --     {"pipe", 50}
  --   },
  --   result = "advanced-smelter"
  -- },
    ---------------
    -- CASTER T1 --
    ---------------
  {
    type = "recipe",
    name = "basic-caster",
    energy_required = 3,
    enabled = false,
    ingredients = {
      {"stone-brick", 15},
      {"iron-gear-wheel", 25},
      {"electronic-circuit", 10},
      {"pipe", 30}
    },
    result = "basic-caster"
  },
    ---------------
    -- CASTER T2 --
    ---------------
  {
    type = "recipe",
    name = "advanced-caster",
    energy_required = 5,
    enabled = false,
    ingredients = {
      {"basic-caster", 1},
      {"steel-plate", 20},
      {"advanced-circuit", 10},
      {"stone-brick", 25},
      {"pipe", 15}
    },
    result = "advanced-caster"
  }
})
