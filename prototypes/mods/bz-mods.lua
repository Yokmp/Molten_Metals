-- ratio: 1:20
--//TODO Balancing, more recipes
--//? more techs ?

local tech
local ore

if mods["bzaluminum"] and settings.startup["ymm-use-aluminum-ore"].value then --//TODO need more stuff
  ore = "aluminum-ore"
  icons[ore] = icons.molten_aluminium
  make_molten_fluid(ore)
  data.raw.fluid["molten-"..ore].icons = {icons:get(ore)}
  make_new_smelting_recipe(ore, {1,1}, {20,20}, get_energy_required("alumina"))
  make_new_casting_recipe(ore, "alumina", {20,20}, {1,1}, get_energy_required("alumina"))
-- aluminum-plate

  tech = "aluminium-casting"
  icons[tech] = icons.aluminium_tech
  make_new_technology(tech, "aluminum-6061", {}, {}, "alumina") --2219
  data.raw.technology[tech].icons = {icons:get(tech)}
  technology_set_parent(tech, "advanced-material-processing")
  technology_add_effect(tech, "molten-aluminum-ore")
  technology_add_effect(tech, "molten-alumina")
end

if mods["bzlead"] and settings.startup["ymm-use-lead-ore"].value then
  ore = "lead-ore"
  icons[ore] = icons.molten_lead
  make_molten_fluid(ore)
  data.raw.fluid["molten-lead-ore"].icons = {icons:get(ore)}
  make_new_smelting_recipe(ore, {1,1}, {20,20}, get_energy_required("lead-plate"))
  make_new_casting_recipe(ore, "lead-plate", {20,20}, {1,1}, get_energy_required("lead-plate"))

  tech = "lead-casting"
  icons[tech] = icons.lead_tech
  make_new_technology(tech, "lead-plate", {}, {}, "lead-plate")
  data.raw.technology[tech].icons = {icons:get(tech)}
  technology_set_parent(tech, "advanced-material-processing")
  technology_add_effect(tech, "molten-lead-ore")
  technology_add_effect(tech, "molten-lead-plate")
end

if mods["bztitanium"] and settings.startup["ymm-use-titanium-ore"].value then --//? should it depend on adv-mat-proc-2 ?
  ore = "titanium-ore"
  icons[ore] = icons.molten_titanium
  make_molten_fluid(ore)
  data.raw.fluid["molten-titanium-ore"].icons = {icons:get(ore)}
  make_new_smelting_recipe(ore, {1,1}, {20,20}, get_energy_required("titanium-plate"))
  make_new_casting_recipe(ore, "titanium-plate", {20,20}, {1,1}, get_energy_required("titanium-plate"))

  tech = "titanium-processing"
  technology_add_effect(tech, "molten-titanium-ore")
  technology_add_effect(tech, "molten-titanium-plate")
end
if mods["bztungsten"] and settings.startup["ymm-use-tungsten-ore"].value then
  ore = "tungsten-ore"
  make_molten_fluid(ore)
  make_new_smelting_recipe(ore, {1,1}, {20,20}, get_energy_required("tungsten-plate"))
  make_new_casting_recipe(ore, "tungsten-plate", {40,40}, {1,1}, get_energy_required("tungsten-plate"))--{2.13,4.26})
  make_new_casting_recipe(ore, "tungsten-carbide", {100,100}, {2,2}, get_energy_required("tungsten-carbide"))--{21.3,21.3})
  make_new_casting_recipe(ore, "rocket-engine-nozzle", {40,40}, {1,1}, get_energy_required("rocket-engine-nozzle"))--{5,5})

  tech = "tungsten-processing"
  technology_add_effect(tech, "molten-tungsten-ore")
  technology_add_effect(tech, "molten-tungsten-plate")
  technology_add_effect(tech, "molten-tungsten-carbide")
  technology_add_effect("rocket-silo", "molten-rocket-engine-nozzle")
end