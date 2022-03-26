
-- {
--   ["key-name"] = {
--     name = "resource-name",
--     type = "basic-solid",
--     results = {
--       {
--         name = "iron-ore",
--         type = "item"
--       }
--     }
--   }
-- }


---returns a table containing all minable recources(*basic-solid only!*); removes the ones specified in the **blacklist**
---@param filter? boolean
---@return table
function get_minable_resouces(filter)
  filter = filter or true
  local minable_resources = {}

  for key, value in pairs(data.raw.resource) do
    minable_resources[key] = {name=key, type=value.category or "basic-solid", results={}}
    if value.minable.result then
      local _name = value.minable.result
      local _type = value.minable.type or "item"
      minable_resources[key].results = {{name=_name, type=_type}}
    end
    if value.minable.results then
      for j, result in ipairs(value.minable.results) do
        minable_resources[key].results[j] = {type=result.type, name=result.name}
      end
    end
  end
  if filter then
    for _, name in ipairs(blacklist.ores) do
      for key, value in pairs(minable_resources) do
        if name == key then -- find isnt strict enough
          minable_resources[key] = nil
        end
        if tostring(value.type) ~= "basic-solid" then
          minable_resources[key] = nil
        end
      end
    end
    return minable_resources
  else
    return minable_resources
  end
end
-- log(serpent.block(get_minable_resouces()))
-- error("get_all_minable_resouces()")


---returns wether or not a given resource is minable
---@param name string ore name
local function is_ore(name)
  local _resources = get_minable_resouces()

  for key, table in pairs(_resources) do
    for _, result in ipairs(table.results) do -- maybe modded resources have more than 1 result
      if result.name == name then return true end
    end
  end

  return false
end
-- log(serpent.block(is_ore( "iron-stick" )))
-- log(serpent.block(is_ore( "iron-ore" )))
-- assert(1==2, "is_ore()")


---Returns a list of all recipes using the given ingredient
---@param item_name string
---@return table table List of recipe names
function get_recipes_byingredient(item_name)
  if data.raw.item[item_name] then
    local recipes = {}

    for recipe_name, data_recipe in pairs(data.raw.recipe) do
      if yutil.check_table(data_recipe.ingredients) then
        for _, ingredient in ipairs(data_recipe.ingredients) do
          if ingredient.name and ingredient.name == item_name then table.insert(recipes, recipe_name)
          elseif ingredient[1] and ingredient[1] == item_name then table.insert(recipes, recipe_name)
          end
        end
      end

      if data_recipe.normal then
        if yutil.check_table(data_recipe.normal.ingredients) then
          for _, ingredient in ipairs(data_recipe.normal.ingredients) do
            if ingredient.name == item_name then table.insert(recipes, recipe_name) end
          end
        end
      end

      if data_recipe.expensive then
        if yutil.check_table(data_recipe.expensive.ingredients) then
          for _, ingredient in ipairs(data_recipe.expensive.ingredients) do
            if ingredient.name == item_name then table.insert(recipes, recipe_name) end
          end
        end
      end
    end
  return recipes
  else
    log(" Item not found: "..tostring(item_name))
    error(" Item not found: "..tostring(item_name))
  end
end
-- log(serpent.block(get_recipes_byingredient("iron-ore")))
-- log(serpent.block(get_recipes_byingredient("uranium-ore")))
-- log(serpent.block(get_recipes_byingredient("copper-plate")))
-- assert(1==2, "get_recipes_byingredient()")


---Returns a table containing the results of the given recipe
---@param recipe_name string
---@return table
function get_recipe_results(recipe_name)
    local _return = {results={}, normal={}, expensive={}}

  if data.raw.recipe[recipe_name] then
    local data_recipe = data.raw.recipe[recipe_name]

    if yutil.check_table(data_recipe.results) then
      for i, result in pairs(data_recipe.results) do
        _return.results[i] = yutil.add_pairs( result )
      end
    elseif data_recipe.result then
      _return.results[1] = yutil.add_pairs( {data_recipe.result, data_recipe.result_count} )
    end

    if data_recipe.normal then
      if yutil.check_table(data_recipe.normal.results) then
        for i, result in pairs(data_recipe.normal.results) do
          _return.normal[i] = yutil.add_pairs( result )
        end
      elseif data_recipe.normal.result then
        _return.normal[1] = yutil.add_pairs( {data_recipe.normal.result, data_recipe.normal.result_count} )
      end
    end

    if data_recipe.expensive then
      if yutil.check_table(data_recipe.expensive.results) then
        for i, result in pairs(data_recipe.expensive.results) do
          _return.expensive[i] = yutil.add_pairs( result )
        end
      elseif data_recipe.expensive.result then
        _return.expensive[1] = yutil.add_pairs( {data_recipe.expensive.result, data_recipe.expensive.result_count} )
      end
    end

  else
    log(" Recipe not found: "..tostring(recipe_name))
    error(" Recipe not found: "..tostring(recipe_name))
  end
  return _return
end
-- log(serpent.block( get_recipe_results( "tank" ) ))
-- log(serpent.block( get_recipe_results( "iron-plate" ) ))
-- assert(1==2, "get_recipe_results()")


-- get every recipe which has the ore as ingredient
-- deepcopy it and replace ore with molten and category with ymm_casting (IF it doen't require a fluid?)
-- if the result (is the only one and) has recipes which only has result as ingredient make a casting recipe and tech
--  so we can cast gear-wheels and sticks

