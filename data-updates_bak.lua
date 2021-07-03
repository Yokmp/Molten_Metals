
local yutil = require("prototypes.util")
local MoltenIron = {}

local use_slag = settings.startup["ymm-enable-slag"].value
local resource_types = {"basic-solid"}
local resource_suffixes = {"-ore"}
local categories = {smelting="ymm_smelting", casting="ymm_casting"}
local temperatures = yutil.temperatures


local function get_minable_resouces()
  local minable_resources = {}
  local i = 1

  for key, value in pairs(data.raw.resource) do
    minable_resources[i] = {resource_name=key, type=value.category or "basic-solid", results={}}
    if value.minable.result then
      local _name = value.minable.result
      local _type = value.minable.type or "item"
      minable_resources[i].results = {{name=_name, type=_type}}
    end
    if value.minable.results then
      for j, result in ipairs(value.minable.results) do
        minable_resources[i].results[j] = {type=result.type, name=result.name}
      end
    end
    i = i+1
  end

  return minable_resources
end
-- log(serpent.block(get_minable_resouces()))
-- log(serpent.block(data.raw.resource["uranium-ore"].minable))
-- log(data.raw.fluid["crude-oil"].type)
-- assert(1==2, "get_minable_resouces()")

---@param name string ore/item or fluid name
local function is_ore(name)
  local _resources = get_minable_resouces()

  for _, table in ipairs(_resources) do
    for _, result in ipairs(table.results) do -- maybe modded resources have more than 1 result
      for i, _type in ipairs(resource_types) do
        if table.type == _type and result.name == name then return true end
      end
    end
  end

  return false
end
-- log(serpent.block(is_ore( "iron-stick" )))
-- log(serpent.block(is_ore( "iron-ore" )))
-- assert(1==2, "is_ore()")


local function get_ore_name(item_name, suffixes)
  local _suffixes = suffixes or resource_suffixes
  for _, suffix in ipairs(_suffixes) do
    if string.match(item_name, suffix) then
      return string.gsub(item_name, suffix, "", 1)
    end
  end
end
-- log(serpent.block(get_ore_name( "iron-ore" )))
-- assert(1==2, "get_ore_name()")


local function get_tech_enabled(recipe_name, ore_type) -- TODO: normal, expensive
  local _techs = { effects={enabled=true, recipes={}}, normal={enabled=true, recipes={}}, expensive={enabled=true, recipes={}} }
  for tech_name, value in pairs(data.raw.technology) do
    if --[[patch.technology(tech_name) and]] value.effects then
      for i, effect in ipairs(value.effects) do
        if effect.recipe and effect.recipe == recipe_name then
          _techs.effects.enabled = false
          _techs.effects.recipes[#_techs.effects.recipes+1] = tech_name
        end
      end
      if #_techs.effects.recipes < 1 and string.match(tostring(tech_name), ore_type) then
        _techs.effects.enabled = false
        _techs.effects.recipes[#_techs.effects.recipes+1] = tech_name
      end
    end
    --normal
    --expensive
  end
  return _techs
end
-- log(serpent.block( get_tech_enabled("gold-plate", "gold") ))
-- assert(1==2, "get_tech_enabled()")


---@return table string List of recipe names
local function get_recipe_name_byingredient(item_name)
  if type(item_name) == "string" and data.raw.item[item_name] then
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
-- log(serpent.block(get_recipe_name_byingredient("iron-ore")))
-- log(serpent.block(get_recipe_name_byingredient("uranium-ore")))
-- assert(1==2, "get_recipe_name_byingredient()")


local function get_recipe_results(recipe_name)
    local _return = {results={}, normal={}, expensive={}}

  if type(recipe_name) == "string" and data.raw.recipe[recipe_name] then
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
log(serpent.block( get_recipe_results( "tank" ) ))
log(serpent.block( get_recipe_results( "iron-plate" ) ))
assert(1==2, "get_recipe_results()")





local function make_categories()
  data:extend({
    { type = "recipe-category", name = categories.smelting, },
    { type = "recipe-category", name = categories.casting },
  })
end
make_categories()

local function make_molten_item(item_name)
  local ore_name = get_ore_name(item_name)
  return {
    type = "fluid",
    name = "molten-"..ore_name,
    icon = yutil.get_icon(ore_name),
    icon_size = 64, icon_mipmaps = 4,
    default_temperature = temperatures[ore_name][1] or 1100,
    max_temperature = temperatures[ore_name][2] or 2600,
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    order = "a[molten-"..ore_name.."]",
    auto_barrel = false
  }

end
-- log(serpent.block(make_molten_item("uranium-ore")))
-- assert(1==2, "make_molten_item()")


local function get_molten_recipe_results(ore_name)
  local _return = {{type = "fluid", name = "molten-"..ore_name, amount = 40, temperature = temperatures[ore_name][1] or 1100}}
  local slag = {type = "item", name = "slag-stone", amount_min = 1, amount_max = 3, probability = 0.24}

  if use_slag then table.insert(_return, slag) end
  return _return
end


local function make_smelting_recipe(item_name)
  local ore_name = get_ore_name(item_name)

  return {
    type = "recipe",
    name = "molten-"..ore_name,
    category = categories.smelting,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    show_amount_in_title = true,
    always_show_products = true,
    crafting_machine_tint = yutil.color.moltenmetal.tint,
    normal = {
      main_product = "molten-"..ore_name,
      enabled = false,
      energy_required = 3.2,
      ingredients = {
        {type = "item", name = item_name, amount = 2}
      },
      results = get_molten_recipe_results(ore_name)
    },
    expensive = {
      main_product = "molten-"..ore_name,
      enabled = false,
      energy_required = 3.2,
      ingredients = {
        {type = "item", name = item_name, amount = 2}
      },
      results = get_molten_recipe_results(ore_name)
    }
  }
end
log(serpent.block(make_smelting_recipe( "iron-ore" )))
-- log(serpent.block(make_smelting_recipe( "test-fail" )))
assert(1==2, "make_smelting_recipe()")


-- get every recipe which has the ore as ingredient
-- deepcopy it and replace ore with molten and category with ymm_casting (IF it doen't require a fluid?)
-- if the result (is the only one and) has recipes which only has result as ingredient make a casting recipe and tech
--  so we can cast gear-wheels and sticks


