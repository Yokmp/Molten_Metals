
-- FLUIDS
molten_metals.make_molten_fluid("iron-ore")
molten_metals.make_molten_fluid("copper-ore")
molten_metals.make_molten_fluid("stone")
molten_metals.make_molten_fluid("uranium-ore")


-- TECHNOLOGY
ylib.technology.add_effect("uranium-processing", "molten-uranium-ore")
ylib.technology.add_effect("uranium-processing", "molten-uranium-238")
ylib.technology.add_effect("kovarex-enrichment-process", "molten-uranium-235")

local replace_steel_furnace = settings.startup["ymm-replace-steel-furnace"].value
local replace_electric_furnace = settings.startup["ymm-replace-steel-furnace"].value

tech = "advanced-material-processing"
data.raw.technology[tech].icons = {ylib.icon.icons:get("Molten_Metals", "smelting")}
if replace_steel_furnace then ylib.technology.remove_effect(tech, "steel-furnace") end
ylib.technology.add_effect(tech, "basic-smelter")
ylib.technology.add_effect(tech, "basic-caster")
ylib.technology.add_effect(tech, "molten-iron-ore")
ylib.technology.add_effect(tech, "molten-copper-ore")
ylib.technology.add_effect(tech, "molten-stone")
ylib.technology.add_effect(tech, "molten-iron-plate")
ylib.technology.add_effect(tech, "molten-copper-plate")
ylib.technology.add_effect(tech, "molten-stone-brick")
ylib.technology.add_effect(tech, "molten-steel-plate")

tech = "advanced-material-processing-2"
data.raw.technology[tech].icons = {ylib.icon.icons:get("Molten_Metals", "advanced-smelting")}
if replace_electric_furnace then ylib.technology.remove_effect(tech, "electric-furnace") end
ylib.technology.add_effect(tech, "advanced-smelter")
ylib.technology.add_effect(tech, "advanced-caster")

tech = "railway"
ylib.technology.add_effect(tech, "molten-rail")


-- SMELTING
molten_metals.new_smelting_recipe("iron-ore", "iron-plate")
molten_metals.new_smelting_recipe("copper-ore", "copper-plate")
molten_metals.new_smelting_recipe("stone", "stone-brick")
molten_metals.new_smelting_recipe("uranium-ore", "uranium-processing", "uranium-238", false, 1)
for _, value in pairs(data.raw.recipe["molten-uranium-ore"].normal.results) do
  if value.name == "molten-uranium-ore" then value.amount = 400 end
end
for _, value in pairs(data.raw.recipe["molten-uranium-ore"].expensive.results) do
  if value.name == "molten-uranium-ore" then value.amount = 400 end
end
-- new_smelting_recipe("uranium-ore", "uranium-processing", "uranium-238")


-- CASTING
molten_metals.new_casting_recipe("copper-ore", "copper-ore", "copper-plate", {2,3})
molten_metals.new_casting_recipe("copper-ore", "copper-plate", "copper-cable")
molten_metals.new_casting_recipe("iron-ore", "iron-ore", "iron-plate", {2,3})
molten_metals.new_casting_recipe("iron-ore", "iron-plate", "steel-plate", {1.6,2})
molten_metals.new_casting_recipe("iron-ore", "iron-plate", "iron-gear-wheel", {1,1})
molten_metals.new_casting_recipe("iron-ore", "iron-plate", "iron-stick", {1,1})
molten_metals.new_casting_recipe_ext("iron-ore", "rail", {110,110}, {2,2}) --//TODO combined ingredients (iron+steel)
-- molten_metals.new_casting_recipe("iron-ore", "steel-plate", "rail")
-- table.insert(data.raw.recipe["molten-rail"].ingredients, {type = "item", name = "stone", amount = 1}) -- need fluid mixer soon
molten_metals.new_casting_recipe("stone", "stone", "stone-brick") -- 12:120:3 -> 4:1 vanilla 2:1
-- molten_metals.new_casting_recipe_ext("stone", "stone-brick", {40}, {2}) -- 20:1

molten_metals.new_casting_recipe_ext("uranium-ore", "uranium-235", {2000,2000}, {1,1}, ylib.recipe.get_energy_required("uranium-processing"))
molten_metals.new_casting_recipe_ext("uranium-ore", "uranium-238", {200,200}, {1,1}, ylib.recipe.get_energy_required("uranium-processing"))
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

-- https://mods.factorio.com/mod/Molten_Metals/discussion/6256ffdaf68fa4a923a6fe3b
-- out/probability = multiplier
-- 1.00704934541793
-- 142.857142857143
-- in*multiplier
-- 201.409869083585
-- 28571.4285714286
-- ore to u235 ratio but its to much since there will be no u-238


-- REPLACE FURNACES
if replace_steel_furnace then
  table.insert(data.raw.recipe["basic-smelter"], ylib.recipe.get_ingredients("steel-furnace"))
  data.raw.item["steel-furnace"].flags = {"hidden"}
  data.raw["furnace"]["steel-furnace"].next_upgrade = "basic-smelter"
  data.raw["furnace"]["steel-furnace"].minable.result = "basic-smelter"
  data.raw["furnace"]["stone-furnace"].next_upgrade = "basic-smelter"
  local steel_furnace = ylib.recipe.get_byingredient("steel-furnace")
  if #steel_furnace > 0 then
    for i, recipe in ipairs(steel_furnace) do
      ylib.recipe.replace_ingredient(recipe, "steel-furnace", "basic-smelter")
    end
  end
end
if replace_electric_furnace then
  table.insert(data.raw.recipe["advanced-smelter"], ylib.recipe.get_ingredients("electric-furnace"))
  data.raw.item["electric-furnace"].flags = {"hidden"}
  data.raw.item["electric-furnace"].minable_result = "advanced-smelter"
  data.raw.item["electric-furnace"].next_upgrade = "advanced-smelter"
  local electric_furnace = ylib.recipe.get_byingredient("electric-furnace")
  if #electric_furnace > 0 then
    for _, recipe in ipairs(electric_furnace) do
      ylib.recipe.replace_ingredient(recipe, "electric-furnace", "advanced-smelter")
    end
  end
end
