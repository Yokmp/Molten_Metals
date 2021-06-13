data:extend({
    ----------------
    -- SMELTER T1 --
    ----------------
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
  ------------------
  -- E-SMELTER T3 --
  ------------------
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
    ---------------
    -- CASTER T1 --
    ---------------
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
    ---------------
    -- CASTER T2 --
    ---------------
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
  }
})
