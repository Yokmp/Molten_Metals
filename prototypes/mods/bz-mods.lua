-- ratio: 1:20
if mods["bzaluminum"] and settings.startup["ymm-use-aluminum-ore"].value then
  icons["aluminum-ore"] = icons.molten_aluminium
  make_molten_fluid("aluminum-ore")
  data.raw.fluid["molten-aluminum-ore"].icons = {icons:get("aluminum-ore")}
  make_new_smelting_recipe("aluminum-ore", {1,1}, {20,20}, {3.2,3.2})
  make_new_casting_recipe("aluminum-ore", "alumina", {20,20}, {1,1}, {3.2,3.2})

  tech = "bzaluminum-casting"
  make_new_technology(tech, "aluminum-6061", {}, {}, "alumina") --2219
  technology_set_parent(tech, "advanced-material-processing")
  technology_add_effect(tech, "molten-aluminum-ore")
  technology_add_effect(tech, "molten-alumina")
  -- log(serpent.block(data.raw.technology["bzaluminum-casting"]))

end
if mods["bzlead"] and settings.startup["ymm-use-lead-ore"].value then
  icons["lead-ore"] = icons.molten_lead
  make_molten_fluid("lead-ore")
  data.raw.fluid["molten-lead-ore"].icons = {icons:get("lead-ore")}
  make_new_smelting_recipe("lead-ore", {1,1}, {20,20}, {3.2,3.2})
  make_new_casting_recipe("lead-ore", "lead-plate", {20,20}, {1,1}, {3.2,3.2})

  tech = "advanced-material-processing"
  -- make_new_technology("lead-plate-casting", "lead-plate", {}, {}, "lead-plate")
  -- technology_set_parent("lead-plate-casting", "advanced-material-processing")
  technology_add_effect(tech, "molten-lead-ore")
  technology_add_effect(tech, "molten-lead-plate")
end
if mods["bztitanium"] and settings.startup["ymm-use-titanium-ore"].value then
  icons["titanium-ore"] = icons.molten_titanium
  make_molten_fluid("titanium-ore")
  data.raw.fluid["molten-titanium-ore"].icons = {icons:get("titanium-ore")}
  make_new_smelting_recipe("titanium-ore", {1,1}, {20,20}, {3.2,3.2})
  make_new_casting_recipe("titanium-ore", "titanium-plate", {20,20}, {1,1}, {3.2,3.2})

  tech = "advanced-material-processing"
  technology_add_effect(tech, "molten-titanium-ore")
  technology_add_effect(tech, "molten-titanium-plate")
end
-- if mods["bztungsten"] and settings.startup["ymm-use-tungsten-ore"].value then
  
-- end