
------------
-- RECIPE --
------------

---Enable or disable a recipe/difficulty
---@param recipe_name string
---@param enabled table contains boolean {normal, expensive}
function recipe_set_enabled(recipe_name, enabled)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].normal.enabled = enabled[1]
    data.raw.recipe[recipe_name].expensive.enabled = enabled[2]
  else
    log("Unknown recipe: "..tostring(recipe_name))
  end
end
-- recipe_set_enabled("tank", {true,false})
-- log(serpent.block(data.raw.recipe["tank"]))
-- error("recipe_set_enabled()")

---Sets a recipes required energy
---@param recipe_name string
---@param energy table contains float {normal, expensive}
function recipe_set_energy(recipe_name, energy)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].normal.energy_required = energy[1]
    data.raw.recipe[recipe_name].expensive.energy_required = energy[2]
  else
    log("Unknown recipe: "..tostring(recipe_name))
  end
end
-- recipe_set_energy("tank", {1,1})
-- log(serpent.block(data.raw.recipe["tank"]))
-- error("recipe_set_energy()")

---Sets a recipes ingredient temperature
---@param recipe_name string
---@param temperature table contains integers {normal, expensive}
function recipe_set_ingredient_temperature(recipe_name, temperature)
  if data.raw.recipe[recipe_name] then
    for index, value in ipairs(data.raw.recipe[recipe_name].normal.ingredients) do
      if value.temperature and string.find(value.name, "molten-", 0, true) then
        data.raw.recipe[recipe_name].normal.ingredients[index].temperature = temperature[1]
        data.raw.recipe[recipe_name].expensive.ingredients[index].temperature = temperature[2] -- lets hope theyre the same
      end
    end
  else
    log("Unknown recipe: "..tostring(recipe_name))
  end
end
-- recipe_set_ingredient_temperature("molten-iron-plate", {123,456})
-- log(serpent.block(data.raw.recipe["molten-iron-plate"]))
-- error("recipe_set_ingredient_temperature()")

---Sets a recipes results temperature
---@param recipe_name string
---@param temperature table contains integers {normal, expensive}
function recipe_set_result_temperature(recipe_name, temperature)
  if data.raw.recipe[recipe_name] then
    for index, value in ipairs(data.raw.recipe[recipe_name].normal.results) do
      if value.temperature and string.find(value.name, "molten-", 0, true) then
        data.raw.recipe[recipe_name].normal.results[index].temperature = temperature[1]
        data.raw.recipe[recipe_name].expensive.results[index].temperature = temperature[2] -- lets hope theyre the same
      end
    end
  else
    log("Unknown recipe: "..tostring(recipe_name))
  end
end
-- recipe_set_result_temperature("molten-iron-ore", {123,456})
-- log(serpent.block(data.raw.recipe["molten-iron-ore"]))
-- error("recipe_set_result_temperature()")


----------------
-- TECHNOLOGY --
----------------

---Adds a recipe as effect to a technology
---@param technology_name string
---@param recipe_name string
function technology_add_effect(technology_name, recipe_name) --TODO add difficulty
  if data.raw.technology[technology_name] and data.raw.technology[technology_name].effects then
    table.insert(data.raw.technology[technology_name].effects, { type = "unlock-recipe", recipe = recipe_name })
    log("added "..recipe_name.." to ".. technology_name)
  else
    log("Unknown technology or missing key: "..tostring(technology_name))
  end
end
-- technology_add_effect("tank", "test-recipe")
-- log(serpent.block(data.raw.technology["tank"]))
-- error("technology_add_effect()")

function technology_remove_effect(technology_name, recipe_name)
  if data.raw.technology[technology_name] and data.raw.technology[technology_name].effects then
    for index, value in ipairs(data.raw.technology[technology_name].effects) do
      if value.recipe == recipe_name then
        table.remove(data.raw.technology[technology_name].effects, index)
        log("removed "..recipe_name.." from ".. technology_name)
      end
    end
  else
    log("Unknown technology or missing key: "..tostring(technology_name))
  end
end
-- technology_remove_effect("tank", "cannon-shell")
-- log(serpent.block(data.raw.technology["tank"]))
-- error("technology_remove_effect()")

