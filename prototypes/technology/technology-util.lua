----------------
-- TECHNOLOGY -- --TODO add difficulty
----------------

---Adds a recipe as effect to a technology
---@param technology_name string
---@param recipe_name string
function technology_add_effect(technology_name, recipe_name)
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

---Returns which technologies enable a recipe.
---@param recipe_name string
---@return table
function get_techs_enable_recipe(recipe_name)
  local _techs = {}
  for _, value in pairs(data.raw.technology) do
    if value.effects then
      for _, effect in ipairs(value.effects) do
        if effect.recipe and effect.recipe == recipe_name then
          _techs[#_techs+1] = value.name
        end
      end
    end
  end
  return _techs
end
-- log(serpent.block( get_techs_enable_recipe("iron-ore") ))
-- log(serpent.block( get_techs_enable_recipe("tank") ))
-- assert(1==2, "get_tech_recipe_enabled()")