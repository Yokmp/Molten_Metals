-- REPLACE FURNACES
if settings.startup["ymm-replace-steel-furnace"].value then
  data.raw.item["steel-furnace"].flags = {"hidden"}
  data.raw["furnace"]["steel-furnace"].next_upgrade = "basic-smelter"
  data.raw["furnace"]["steel-furnace"].minable.result = "basic-smelter"
  data.raw["furnace"]["stone-furnace"].next_upgrade = "basic-smelter"
end
if settings.startup["ymm-replace-electric-furnace"].value then
  data.raw.item["electric-furnace"].flags = {"hidden"}
  data.raw.item["electric-furnace"].next_upgrade = "advanced-smelter"
end

-- FLUIDS
make_molten_fluid("iron-ore")
make_molten_fluid("copper-ore")
make_molten_fluid("stone")
make_molten_fluid("uranium-ore")
data.raw.fluid["molten-iron-ore"].icons = {icons:get("molten_iron")}
data.raw.fluid["molten-copper-ore"].icons = {icons:get("molten_copper")}
data.raw.fluid["molten-stone"].icons = {icons:get("stone")}
data.raw.fluid["molten-uranium-ore"].icons = {icons:get("molten_uranium")}

-- TECHNOLOGY
technology_add_effect("uranium-processing", "molten-uranium-ore")
technology_add_effect("uranium-processing", "molten-uranium-238")
technology_add_effect("kovarex-enrichment-process", "molten-uranium-235")

local replace_steel_furnace = settings.startup["ymm-replace-steel-furnace"].value
local replace_electric_furnace = settings.startup["ymm-replace-steel-furnace"].value

tech = "advanced-material-processing"
data.raw.technology[tech].icon = "__Molten_Metals__/graphics/technology/smelting.png"
data.raw.technology[tech].icon_size = 128
if replace_steel_furnace then technology_remove_effect(tech, "steel-furnace") end
technology_add_effect(tech, "basic-smelter")
technology_add_effect(tech, "basic-caster")
technology_add_effect(tech, "molten-iron-ore")
technology_add_effect(tech, "molten-copper-ore")
technology_add_effect(tech, "molten-stone")
technology_add_effect(tech, "molten-iron-plate")
technology_add_effect(tech, "molten-copper-plate")
technology_add_effect(tech, "molten-stone-brick")
technology_add_effect(tech, "molten-steel-plate")

tech = "advanced-material-processing-2"
data.raw.technology[tech].icon = "__Molten_Metals__/graphics/technology/advanced-smelting.png"
data.raw.technology[tech].icon_size = 128
if replace_electric_furnace then technology_remove_effect(tech, "electric-furnace") end
technology_add_effect(tech, "advanced-smelter")
technology_add_effect(tech, "advanced-caster")


-- data:extend({
--   {
--     type = "fluid",
--     name = "waste-water",
--     icon = "__Molten_Metals__/graphics/icons/waste-water.png",
--     icon_size = 64, icon_mipmaps = 4,
--     default_temperature = 80,
--     max_temperature = 100,
--     heat_capacity = "0.1KJ",
--     base_color = color.wastewater.base,
--     flow_color = color.wastewater.flow,
--     order = "z"
--   },
-- })

-- SMELTING
make_new_smelting_recipe( "iron-ore", {2,2}, {40,40}, {3.2,3.2})
make_new_smelting_recipe( "copper-ore", {2,2}, {40,40}, {3.2,3.2})
make_new_smelting_recipe( "stone", {2,2}, {40,40}, {3.2,3.2})
make_new_smelting_recipe( "uranium-ore", {2,2}, {40,40}, {3.2,3.2})

-- CASTING
make_new_casting_recipe("copper-ore", "copper-plate", {20,20}, {1,1}, {1.6,1.6})
make_new_casting_recipe("copper-ore", "copper-cable", {20,20}, {2,2}, {0.5,0.5})
make_new_casting_recipe("iron-ore", "iron-plate", {20,20}, {1,1}, {1.6,1.6})
make_new_casting_recipe("iron-ore", "steel-plate", {80,80}, {1,1}, {8,16})
make_new_casting_recipe("iron-ore", "iron-gear-wheel", {80,80}, {2,2}, {1,1})
make_new_casting_recipe("iron-ore", "iron-stick", {20,20}, {2,2}, {0.5,0.5})
make_new_casting_recipe("iron-ore", "rail", {120,120}, {2,2}, {0.5,0.5})
-- table.insert(data.raw.recipe["molten-rail"].ingredients, {type = "item", name = "stone", amount = 1})
make_new_casting_recipe("stone", "stone-brick", {20,20}, {1,1}, {1.6,1.6})
make_new_casting_recipe("uranium-ore", "uranium-238", {200,200}, {1,1}, {12,12})
make_new_casting_recipe("uranium-ore", "uranium-235", {28571.4285714286/2,28571.4285714286/2}, {1,1}, {12,12})
data.raw.recipe["molten-uranium-238"].normal.results = {
  {type = "item", name = "uranium-238", amount = 1, probability = 0.993},
  {type = "item", name = "uranium-235", amount = 1, probability = 0.007},
  {type = "fluid", name = "steam", amount = 200, temperature = 165}
}
data.raw.recipe["molten-uranium-238"].expensive.results = {
  {type = "item", name = "uranium-238", amount = 1, probability = 0.993},
  {type = "item", name = "uranium-235", amount = 1, probability = 0.007},
  {type = "fluid", name = "steam", amount = 200, temperature = 165}
}

-- out/probability = multiplier
-- 1.00704934541793
-- 142.857142857143
-- in*multiplier
-- 201.409869083585
-- 28571.4285714286
-- ore to u235 ratio but its to much since there will be no u-238

if settings.startup["ymm-use-old-icons"].value then --//TODO move into machines.lua
  data.raw.item["basic-caster"].icons = {icons:get("basic_old")}
  data.raw.item["advanced-caster"].icons = {icons:get("advanced_old")}
end
