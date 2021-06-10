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
      -- {"advanced-circuit", 20},
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
      {"stone-brick", 10},
      {"iron-gear-wheel", 15},
      {"electronic-circuit", 5},
      {"pipe", 15}
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
      -- {"basic-caster", 1},
      {"steel-plate", 10},
      {"advanced-circuit", 10},
      {"stone-brick", 25},
      {"pipe", 20}
    },
    result = "advanced-caster"
  }
})
