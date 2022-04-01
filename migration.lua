for _, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  -- recipes[""].enabled = technologies[""].researched

  if technologies["advanced-material-processing"].researched then
    recipes["basic-caster"].enabled = true
    recipes["basic-smelter"].enabled = true
    recipes["basic-caster"].enabled = true
    recipes["molten-iron-ore"].enabled = true
    recipes["molten-copper-ore"].enabled = true
    recipes["molten-stone"].enabled = true
    recipes["molten-iron-plate"].enabled = true
    recipes["molten-copper-plate"].enabled = true
    recipes["molten-stone-brick"].enabled = true
    recipes["molten-steel-plate"].enabled = true

    if technologies["railway"] then
      recipes["molten-rail"].enabled = true
    end
-- MODS --
    if mods["bzaluminum"] and settings.startup["ymm-use-aluminum-ore"].value and technologies["aluminium-casting"].researched then
      recipes["molten-aluminum-ore"].enabled = true
      recipes["molten-alumina"].enabled = true
    end
    if mods["bzlead"] and settings.startup["ymm-use-lead-ore"].value and technologies["lead-plate-casting"].researched then
      recipes["molten-lead-ore"].enabled = true
      recipes["lead-plate"].enabled = true
    end
    if mods["bztitanium"] and settings.startup["ymm-use-titanium-ore"].value and technologies["titanium-processing"].researched then
      recipes["molten-titanium-ore"].enabled = true
      recipes["molten-titanium-plate"].enabled = true
    end
    if mods["bztungsten"] and settings.startup["ymm-use-tungsten-ore"].value and technologies["tungsten-processing"].researched then
      recipes["molten-tungsten-ore"].enabled = true
      recipes["molten-tungsten-plate"].enabled = true
      recipes["molten-tungsten-carbide"].enabled = true
      recipes["molten-rocket-engine-nozzle"].enabled = technologies["rocket-silo"].researched
    end
  end
end