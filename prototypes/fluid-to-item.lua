-- get_ores() = {
--   ["iron-ore"] = {
--     auto = false,
--     icon = "__Molten_Metals__/graphics/icons/molten-iron.png",
--     name = "iron",
--     order = "e[iron-ore]",
--     ore = "iron-ore",
--     temp_default = 1500,
--     temp_max = 3000
--   },
-- }


---Adds molten-ores to recipes ingredients
local recipes = {}

for ore_name, ore_values in pairs(ores) do


  for recipe, value in pairs(data.raw.recipe) do

    if value.expensive and value.expensive.ingredients then
      if #value.expensive.ingredients == 1 and value.expensive.ingredients[1][1] == ore_name then
        recipes[recipe] = recipes[recipe] or {}
        recipes[recipe].expensive = value.expensive.ingredients
      end
    end

    if value.normal and value.normal.ingredients then
      if #value.normal.ingredients == 1 and value.normal.ingredients[1][1] == ore_name then
        recipes[recipe] = recipes[recipe] or {}
        recipes[recipe].normal = value.normal.ingredients
      end
    end

    if value.ingredients then
      if #value.ingredients == 1 and value.ingredients[1][1] == ore_name then
        local temp = util.copy(data.raw.recipe[recipe])
        temp.name = prefix..recipe
        temp.category = "ymm_casting"
        temp.allow_as_intermediate = false
        temp.allow_intermediates = false
        temp.always_show_products = true
        temp.crafting_machine_tint = color.moltenmetal.tint
        temp.enabled = false
        temp.subgroup = nil
        temp.ingredients = {
          {type = "fluid", name = prefix..ore_values.name, amount = value.ingredients[1][2]*20, temperature = ore_values.temp_default},
          {type = "fluid", name = "water", amount = value.ingredients[1][2]*40}
        }

        if type(value.result) == "string" then
          temp.results = {
            {type = "item",  name = value.result, amount = 1},
            {type = "fluid", name = "steam", amount = 5, temperature = 165}
          }
          temp.main_product = value.result
          temp.result = nil
        end
        data:extend({temp})
        log(serpent.block(temp))
      end
    end
  end
end
-- log(serpent.block(recipes, {comment = false}))
-- assert(1==2, " D I E - fluid-to-item.lua")