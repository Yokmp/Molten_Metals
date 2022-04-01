-- ratio: 1:20
--//TODO Balancing, more recipes
--//? more techs ?

local tech
local ore

if mods["bzaluminum"] and settings.startup["ymm-use-aluminum-ore"].value then --//TODO need more stuff
  ore = "aluminum-ore"
  make_molten_fluid(ore)
  data.raw.fluid["molten-"..ore].icons = {icons:get("molten_aluminium")}
  new_smelting_recipe(ore, "alumina")
  new_casting_recipe(ore, "alumina")
-- aluminum-plate

  tech = "aluminium-casting"
  new_technology(tech, "aluminum-6061", "advanced-material-processing", "alumina") --2219
  data.raw.technology[tech].icons = {icons:get("aluminium_tech")}
  technology_add_effect(tech, "molten-aluminum-ore")
  technology_add_effect(tech, "molten-alumina")
end

if mods["bzlead"] and settings.startup["ymm-use-lead-ore"].value then
  ore = "lead-ore"
  make_molten_fluid(ore)
  data.raw.fluid["molten-lead-ore"].icons = {icons:get("molten_lead")}
  new_smelting_recipe(ore, "lead-plate")
  new_casting_recipe(ore, "lead-plate")

  tech = "lead-casting"
  new_technology(tech, "lead-plate", "advanced-material-processing")
  data.raw.technology[tech].icons = {icons:get("lead_tech")}
  technology_add_effect(tech, "molten-lead-ore")
  technology_add_effect(tech, "molten-lead-plate")
end

if mods["bztitanium"] and settings.startup["ymm-use-titanium-ore"].value then --//? should it depend on adv-mat-proc-2 ?
  ore = "titanium-ore"
  make_molten_fluid(ore)
  data.raw.fluid["molten-titanium-ore"].icons = {icons:get("molten_titanium")}
  new_smelting_recipe(ore, "titanium-plate")
  new_casting_recipe(ore, "titanium-plate")

  tech = "titanium-processing"
  technology_add_effect(tech, "molten-titanium-ore")
  technology_add_effect(tech, "molten-titanium-plate")
end
if mods["bztungsten"] and settings.startup["ymm-use-tungsten-ore"].value then
  ore = "tungsten-ore"
  make_molten_fluid(ore)
  new_smelting_recipe(ore, "tungsten-plate")
  new_casting_recipe(ore, "tungsten-plate")--{2.13,4.26})
  new_casting_recipe(ore, "tungsten-carbide")--{21.3,21.3})
  new_casting_recipe(ore, "rocket-engine-nozzle")--{5,5})

  tech = "tungsten-processing"
  technology_add_effect(tech, "molten-tungsten-ore")
  technology_add_effect(tech, "molten-tungsten-plate")
  technology_add_effect(tech, "molten-tungsten-carbide")
  technology_add_effect("rocket-silo", "molten-rocket-engine-nozzle")
end