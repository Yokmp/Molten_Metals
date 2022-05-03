---@diagnostic disable: need-check-nil

local use_slag = settings.startup["ymm-enable-slag"].value
local disable_temperatures = settings.startup["ymm-fp-workaround"].value



---Creates a smelting recipe, _ore-name_ to _molten-ore-name_
---@param ore_name string also determines the main product
---@param amount_in? table {normal, expensive}
---@param amount_out? table {normal, expensive}
---@param energy? table {normal, expensive}
---@param enabled? table {normal, expensive}
function molten_metals.new_smelting_recipe_ext(ore_name, amount_in, amount_out, energy, enabled)
  amount_in = amount_in or {2,2}
  amount_out = amount_out or {40,40}
  energy = energy or {0.5,0.5} --{3.2,3.2}
  enabled = enabled or {false, false}
  local temperature = molten_metals.ore_definition(ore_name).melting

--!- Factory Planner Workaround
if disable_temperatures then
  temperature = nil
end


  local recipe =  {
    type = "recipe",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name."..ore_name}, " ", {"item-name.smelting"}},
    category = category.smelting,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    show_amount_in_title = true,
    always_show_products = true,
    order = "m[molten-"..ore_name.."]",
    crafting_machine_tint = molten_metals.color.moltenmetal.tint,
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
    local slag_normal = {type = "item", name = "slag", amount_min = 1, amount_max = math.floor(amount_out[1]/10), probability = 0.24}
    local slag_expensive = {type = "item", name = "slag", amount_min = 1, amount_max = math.floor(amount_out[2]/10), probability = 0.24}
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
---@param ore_name string ingredient
---@param recipe_name string the recipe used to calculate the input amount
---@param result? string must be set if recipe and result names differ; used to calc the output amount
---@param enabled? boolean
---@param multiplier? number 3 - applied to ingredients and results
function molten_metals.new_smelting_recipe(ore_name, recipe_name, result, enabled, multiplier) --!-//BUG needs result to calc amount
  multiplier = multiplier or 3 --!-//BUG ratio isnt preserved correctly (eg uranium)
  result = result or recipe_name
  local amount_in = ylib.recipe.get_amount_in(recipe_name, ore_name)
  local amount_out = ylib.recipe.get_amount_out(recipe_name, result)
  amount_in[1] = amount_in[1]*(2*multiplier) -- ratio is 1:20
  amount_in[2] = amount_in[2]*(2*multiplier)
  amount_out[1] = amount_out[1]*(40*multiplier)
  amount_out[2] = amount_out[2]*(40*multiplier) -- no need to nil check here. let is burn

  info("new smelting recipe: molten-"..ore_name.." for: "..result)
  molten_metals.new_smelting_recipe_ext( ore_name, amount_in, amount_out, ylib.recipe.get_energy_required(recipe_name), enabled or false)
end


---Creates a new casting recipe
---@param fluid_name string ``"molten-"..fluid_name`` recipe and ingredient name (molten-result-name)
---@param result_name string also sets the main product, must be an item
---@param amount_in? table ``{normal, expensive} or {20,20}``
---@param amount_out? table ``{normal, expensive} or (recipe_get_amount_out(result_name) or {1,1})``
---@param energy? table ``{normal, expensive} or {0.5,0.5}``
---@param enabled? table ``{normal, expensive} or false``
function molten_metals.new_casting_recipe_ext(fluid_name, result_name, amount_in, amount_out, energy, enabled)
  amount_in = amount_in or {20,20}
  amount_out = amount_out or (ylib.recipe.get_amount_out(result_name) or {1,1})
  energy = energy or {0.5,0.5} --vanilla default
  enabled = enabled or {false, false}
  temperature = molten_metals.ore_definition(fluid_name)
  local f_result = "steam"
  local f_temp = temperature.steam_temp

--!- Factory Planner Workaround
if disable_temperatures then
  temperature.melting = nil
end

  local recipe = {
    type = "recipe",
    name = "molten-"..result_name,
    icons = {ylib.icon.get_icon(result_name), ylib.icon.icons:get("Molten_Metals", "molten-drop-result", 0.5, {0,-6})},
    localised_name = {"", {"item-name."..result_name}, " ", {"item-name.casting"}},
    category = category.casting,
    show_amount_in_title = true,
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    always_show_products = true,
    order = "m[molten-"..result_name.."]",
    crafting_machine_tint = molten_metals.color.moltenmetal.tint,
    normal = {
      main_product = result_name,
      enabled = enabled[1],
      energy_required = energy[1], -- 1.6 (3.2 at speed 2)
      ingredients = {
        {type = "fluid", name = "molten-"..fluid_name, amount = amount_in[1], temperature = temperature.melting},
        {type = "fluid", name = "water", amount = math.floor((amount_in[1]*1.8)/10)*10}
      },
      results = {
        {type = "item",  name = result_name, amount = amount_out[1]},
        {type = "fluid", name = f_result, amount = 12, temperature = f_temp}
      }
    },
    expensive = {
      main_product = result_name,
      enabled = enabled[2],
      energy_required = energy[2],
      ingredients = {
        {type = "fluid", name = "molten-"..fluid_name, amount = amount_in[2], temperature = temperature.melting},
        {type = "fluid", name = "water", amount = math.ceil(amount_in[1]*2.2)}
      },
      results = {
        {type = "item",  name = result_name, amount = amount_out[2]},
        {type = "fluid", name = f_result, amount = 6, temperature = f_temp}
      }
    }
  }

data:extend({recipe})
end
-- make_new_casting_recipe("iron-ore", "iron-plate", {20,20}, {1,1}, {1.6,1.6})
-- log(serpent.block(data.raw.recipe["molten-iron-plate"]))
-- make_new_casting_recipe("iron-ore", "iron-plate")
-- log(serpent.block(data.raw.recipe["molten-iron-plate"]))
-- error("make_new_smelting_recipe()")

---Wrapper for new_casting_recipe_ext()
---@param ore_name string ore-name, __NOT__ fluid-name
---@param ingredient string defines input amount
---@param result string item-name, also defines output amount
---@param multiplier? table ``{3,3}`` - applied to ingredients[1] and results[2]
function molten_metals.new_casting_recipe(ore_name, ingredient, result, multiplier)
  multiplier = multiplier or {3,3}
  local energy = ylib.recipe.get_energy_required(result)
  local amount_in = ylib.recipe.get_amount_in(result, ingredient)
  local amount_out = ylib.recipe.get_amount_out(result)
  energy[1] = energy[1]/2 --casting machine speed is 1 and 1.5
  energy[2] = energy[2]/2 --vanilla furnace is 2 (vanilla energy min is 0.5)

  amount_in[1] = amount_in[1] < 20 and (amount_in[1]*20)*multiplier[1] -- if returns 0?
  amount_in[2] = amount_in[2] < 20 and (amount_in[2]*20)*multiplier[1] -- if returns nil?

  amount_out[1] = amount_out[1] < 20 and amount_out[1]*multiplier[2]
  amount_out[2] = amount_out[2] < 20 and amount_out[2]*multiplier[2]

  info("new casting recipe for: "..result)
  molten_metals.new_casting_recipe_ext(ore_name, result, amount_in, amount_out, energy)
end
-- new_casting_recipe("stone", "stone", "stone-brick")
-- log(serpent.block(data.raw.recipe["molten-stone-brick"]))
-- error("new_casting_recipe")
