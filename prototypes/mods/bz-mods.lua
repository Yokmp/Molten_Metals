
if mods["bzaluminum"] then
  make_molten_fluid("aluminum-ore")
  make_new_smelting_recipe("aluminum-ore", {1,1}, {20,20}, {3.2,3.2})
  make_new_casting_recipe("aluminum-ore", "alumina", {20,20}, {1,1}, {3.2,3.2})

  tech = "bzaluminum-casting"
  make_new_technology(tech, "aluminum-6061", {}, {}, "alumina")
  technology_set_parent(tech, "advanced-material-processing")
  technology_add_effect(tech, "molten-aluminum-ore")
  technology_add_effect(tech, "molten-alumina")
  -- log(serpent.block(data.raw.technology["bzaluminum-casting"]))

end
if mods["bzlead"] then
  make_molten_fluid("lead-ore")
  make_new_smelting_recipe("lead-ore", {1,1}, {20,20}, {3.2,3.2})
  make_new_casting_recipe("lead-ore", "lead-plate", {20,20}, {1,1}, {3.2,3.2})

  tech = "advanced-material-processing"
  -- make_new_technology("lead-plate-casting", "lead-plate", {}, {}, "lead-plate")
  -- technology_set_parent("lead-plate-casting", "advanced-material-processing")
  technology_add_effect(tech, "molten-lead-ore")
  technology_add_effect(tech, "molten-lead-plate")
end
if mods["bztitanium"] then
  make_molten_fluid("titanium-ore")
  make_new_smelting_recipe("titanium-ore", {1,1}, {20,20}, {3.2,3.2})
  make_new_casting_recipe("titanium-ore", "titanium-plate", {20,20}, {1,1}, {3.2,3.2})

  tech = "advanced-material-processing"
  technology_add_effect(tech, "molten-titanium-ore")
  technology_add_effect(tech, "molten-titanium-plate")
end
-- if mods["bztungsten"] then
  
-- end