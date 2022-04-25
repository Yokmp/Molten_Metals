-- ratio: 1:20
--//TODO Balancing, more recipes
--?-// more techs ?

local tech
local ore

if mods["bzaluminum"] and settings.startup["ymm-use-aluminum-ore"].value then --//TODO need more stuff
  ore = "aluminum-ore"
  molten_metals.make_molten_fluid(ore)
  molten_metals.new_smelting_recipe(ore, "alumina")
  molten_metals.new_casting_recipe(ore, ore, "alumina")
-- aluminum-plate

  tech = "aluminium-casting"
  molten_metals.new_technology(tech, "aluminum-6061", "advanced-material-processing", "alumina") --2219
  ylib.technology.add_effect(tech, "molten-aluminum-ore")  --ingredient
  ylib.technology.add_effect(tech, "molten-alumina")       --result
end

if mods["bzlead"] and settings.startup["ymm-use-lead-ore"].value then
  ore = "lead-ore"
  molten_metals.make_molten_fluid(ore)
  molten_metals.new_smelting_recipe(ore, "lead-plate")
  molten_metals.new_casting_recipe(ore, ore, "lead-plate")

  tech = "lead-casting"
  molten_metals.new_technology(tech, "lead-plate", "advanced-material-processing")
  ylib.technology.add_effect(tech, "molten-lead-ore")
  ylib.technology.add_effect(tech, "molten-lead-plate")
end

if mods["bztitanium"] and settings.startup["ymm-use-titanium-ore"].value then --//? should it depend on adv-mat-proc-2 ?
  ore = "titanium-ore"
  molten_metals.make_molten_fluid(ore)
  molten_metals.new_smelting_recipe(ore, "titanium-plate")
  molten_metals.new_casting_recipe(ore, ore, "titanium-plate")

  tech = "titanium-processing"
  data.raw.technology[tech].icons = molten_metals.technology_molten_icon(tech, "titanium-plate")
  ylib.technology.add_effect(tech, "molten-titanium-ore")
  ylib.technology.add_effect(tech, "molten-titanium-plate")
end

if mods["bztungsten"] and settings.startup["ymm-use-tungsten-ore"].value then
  ore = "tungsten-ore"
  molten_metals.make_molten_fluid(ore)
  molten_metals.new_smelting_recipe(ore, "tungsten-plate")
  molten_metals.new_casting_recipe(ore, ore, "tungsten-plate")--{2.13,4.26})
  molten_metals.new_casting_recipe(ore, "tungsten-plate", "tungsten-carbide")--{21.3,21.3})
  molten_metals.new_casting_recipe_ext(ore, "rocket-engine-nozzle", {80,80}, {1,1})
  -- new_casting_recipe(ore, "tungsten-plate", "rocket-engine-nozzle")--{5,5})

  tech = "tungsten-processing"
  data.raw.technology[tech].icons = molten_metals.technology_molten_icon(tech, "tungsten-plate")
  ylib.technology.add_effect(tech, "molten-tungsten-ore")
  ylib.technology.add_effect(tech, "molten-tungsten-plate")
  ylib.technology.add_effect(tech, "molten-tungsten-carbide")
  ylib.technology.add_effect("rocket-silo", "molten-rocket-engine-nozzle")
end