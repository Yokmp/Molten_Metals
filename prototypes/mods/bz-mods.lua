
if mods["bzaluminum"] then
  make_molten_fluid("aluminum-ore")
  make_new_casting_recipe("aluminum-ore", "alumina", {20,20}, {1,1}, {3.2,3.2})
  make_new_smelting_recipe("aluminum-ore", {1,1}, {20,20}, {3.2,3.2})

  tech = "bzaluminum-casting"
  make_new_technology(tech, "aluminium-casting", {}, {}, "alumina")
  technology_set_parent(tech, "advanced-material-processing")
  technology_add_effect(tech, "molten-aluminum-ore")
  technology_add_effect(tech, "molten-alumina")

end
if mods["bzlead"] then
  make_molten_fluid("lead-ore")
  make_new_casting_recipe("lead-ore", "lead-plate", {20,20}, {1,1}, {3.2,3.2})
  make_new_smelting_recipe("lead-ore", {1,1}, {20,20}, {3.2,3.2})

  tech = "bzlead-casting"
  make_new_technology(tech, "lead-casting", {}, {}, "lead-ore")
  technology_set_parent(tech, "advanced-material-processing")
  technology_add_effect(tech, "molten-lead-ore")
  technology_add_effect(tech, "molten-lead-plate")
end
-- if mods["bztitanium"] then
  
-- end
-- if mods["bztungsten"] then
  
-- end