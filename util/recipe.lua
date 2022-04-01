
local use_slag = settings.startup["ymm-enable-slag"].value


---Creates a smelting recipe, _ore-name_ to _molten-ore-name_
---@param ore_name string also determines the main product
---@param amount_in? table {normal, expensive}
---@param amount_out? table {normal, expensive}
---@param energy? table {normal, expensive}
---@param enabled? table {normal, expensive}
function new_smelting_recipe_ext(ore_name, amount_in, amount_out, energy, enabled)
  amount_in = amount_in or {2,2}
  amount_out = amount_out or {40,40}
  energy = energy or {0.5,0.5} --{3.2,3.2}
  enabled = enabled or {false, false}
  local temperature = yutil.ore_definition(ore_name).min

  local recipe =  {
    type = "recipe",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name."..ore_name}, " ", {"item-name.smelting"}},
    category = categories.smelting,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    show_amount_in_title = true,
    always_show_products = true,
    order = "m[molten-"..ore_name.."]",
    crafting_machine_tint = yutil.color.moltenmetal.tint,
    normal = {
      main_product = "molten-"..ore_name,
      enabled = enabled[1],
      energy_required = energy[1],
      ingredients = {
        {type = "item", name = ore_name, amount = amount_in[1]}
      },
      results = {
        {type = "fluid", name = "molten-"..ore_name, amount = amount_out[1], temperature = temperature}
      }
    },
    expensive = {
      main_product = "molten-"..ore_name,
      enabled = enabled[2],
      energy_required = energy[2],
      ingredients = {
        {type = "item", name = ore_name, amount = amount_in[2]}
      },
      results = {
        {type = "fluid", name = "molten-"..ore_name, amount = amount_out[2], temperature = temperature}
      }
    }
  }
  if use_slag then
    local slag_normal = {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.floor(amount_out[1]/10), probability = 0.24}
    local slag_expensive = {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.floor(amount_out[2]/10), probability = 0.24}
    table.insert(recipe.normal.results, slag_normal)
    table.insert(recipe.expensive.results, slag_expensive)
  end

  data:extend({recipe})
end
-- make_new_smelting_recipe( "iron-ore", {2,2}, {40,40}, {3.2,3.2})
-- log(serpent.block(data.raw.recipe["molten-iron"]))
-- make_new_smelting_recipe( "iron-ore")
-- log(serpent.block(data.raw.recipe["molten-iron-ore"]))
-- error("make_new_smelting_recipe()")

---Wrapper for new_smelting_recipe_ext()
---@param ingredient string ore-name
---@param result string item-name, __NOT__ fluid-name
---@param enabled? boolean
function new_smelting_recipe(ingredient, result, enabled)
  new_smelting_recipe_ext(
    ingredient,
    get_recipe_amount_in(result, ingredient),
    get_recipe_amount_out(result),
    get_energy_required(result),
    enabled or false
  )
end


---Creates a new casting recipe
---@param fluid_name string recipe and ingredient name (molten-result-name)
---@param result_name string also sets the main product, must be an item
---@param amount_in? table {normal, expensive} {1,1}
---@param amount_out? table ``{normal, expensive} or (get_recipe_amount_out(result_name) or {1,1})``
---@param energy? table {normal, expensive} get_energy_required(result_name) or number
---@param enabled? table {normal, expensive} false
function new_casting_recipe_ext(fluid_name, result_name, amount_in, amount_out, energy, enabled)
  amount_in = amount_in or {20,20}
  amount_out = amount_out or (get_recipe_amount_out(result_name) or {1,1})
  if not energy then
    energy = get_energy_required(result_name) --casting machine speed is 1 and 1.5
  end
  enabled = enabled or {false, false}
  temperature = yutil.ore_definition(fluid_name).min

data:extend({{
  type = "recipe",
  name = "molten-"..result_name,
  localised_name = {"", {"item-name."..result_name}, " ", {"item-name.casting"}},
  category = categories.casting,
  show_amount_in_title = true,
  allow_as_intermediate = false,
  allow_intermediates = false,
  hidden = false,
  hide_from_player_crafting = true,
  always_show_products = true,
  order = "m[molten-"..result_name.."]",
  crafting_machine_tint = yutil.color.moltenmetal.tint,
  normal = {
    main_product = result_name,
    enabled = enabled[1],
    energy_required = energy[1], -- 1.6 (3.2 at speed 2)
    ingredients = {
      {type = "fluid", name = "molten-"..fluid_name, amount = amount_in[1], temperature = temperature},
      {type = "fluid", name = "water", amount = 40}
    },
    results = {
      {type = "item",  name = result_name, amount = amount_out[1]},
      {type = "fluid", name = "steam", amount = 10, temperature = 165}
    }
  },
  expensive = {
    main_product = result_name,
    enabled = enabled[2],
    energy_required = energy[2],
    ingredients = {
      {type = "fluid", name = "molten-"..fluid_name, amount = amount_in[2], temperature = temperature},
      {type = "fluid", name = "water", amount = 60}
    },
    results = {
      {type = "item",  name = result_name, amount = amount_out[2]},
      {type = "fluid", name = "steam", amount = 10, temperature = 165}
    }
  }
}})
end
-- make_new_casting_recipe("iron-ore", "iron-plate", {20,20}, {1,1}, {1.6,1.6})
-- log(serpent.block(data.raw.recipe["molten-iron-plate"]))
-- make_new_casting_recipe("iron-ore", "iron-plate")
-- log(serpent.block(data.raw.recipe["molten-iron-plate"]))
-- error("make_new_smelting_recipe()")

---Wrapper for new_casting_recipe_ext()
---@param ingredient string ore-name, __NOT__ fluid-name
---@param result string item-name
function new_casting_recipe(ingredient, result)
  new_casting_recipe_ext(
  ingredient,
  result,
  get_recipe_amount_in(result, ingredient),
  get_recipe_amount_out(result)
)
end



    ------------
    -- HELPER --
    ------------


---Enable or disable a recipe/difficulty
---@param recipe_name string
---@param enabled table contains boolean {normal, expensive}
function recipe_set_enabled(recipe_name, enabled)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].normal.enabled = enabled[1]
    data.raw.recipe[recipe_name].expensive.enabled = enabled[2]
    if logging then log(recipe_name.." enabled: ".. tostring(enabled[1]) ..", ".. tostring(enabled[2])) end
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



