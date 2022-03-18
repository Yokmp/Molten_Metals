
local yutil = require("prototypes.util")


---Creates a new casting recipe
---@param ore_name string determines the recipe- and ingredient name (molten-ore-name)
---@param result_name string also determines the main product
---@param amount_in table {normal, expensive}
---@param amount_out table {normal, expensive}
---@param energy table {normal, expensive}
function make_new_recipe(ore_name, result_name, amount_in, amount_out, energy)

data:extend({
  type = "recipe",
  name = "molten-"..ore_name,
  category = categories.casting,
  show_amount_in_title = true,
  allow_as_intermediate = false,
  allow_intermediates = false,
  hidden = false,
  hide_from_player_crafting = true,
  always_show_products = true,
  order = "m[molten-"..result_name"]",
  crafting_machine_tint = yutil.color.moltenmetal.tint,
  normal = {
    main_product = result_name,
    enabled = false,
    energy_required = energy[1], -- 1.6 (3.2 at speed 2)
    ingredients = {
      {type = "fluid", name = "molten-"..ore_name, amount = amount_in[1], temperature = yutil.temperatures[ore_name][1] or 1100},
      {type = "fluid", name = "water", amount = 40}
    },
    results = {
      {type = "item",  name = result_name, amount = amount_out[1]},
      {type = "fluid", name = "steam", amount = 5, temperature = 165}
    }
  },
  expensive = {
    main_product = result_name,
    enabled = false,
    energy_required = energy[2],
    ingredients = {
      {type = "fluid", name = "molten-"..ore_name, amount = amount_in[2], temperature = yutil.temperatures[ore_name][1] or 1100},
      {type = "fluid", name = "water", amount = 80}
    },
    results = {
      {type = "item",  name = result_name, amount = amount_out[2]},
      {type = "fluid", name = "steam", amount = 10, temperature = 165}
    }
  }
})
end

function add_recipe_to_technology(technology_name, recipe_name) --TODO add difficulty
  if data.raw.technology[technology_name] and data.raw.technology[technology_name].effects then
    table.insert(data.raw.technology[technology_name].effects, { type = "unlock-recipe", recipe = recipe_name })
  end
end

---@param recipe_name string
---@param enabled table contains boolean {normal, expensive}
function casting_recipe_set_enabled(recipe_name, enabled)
  if data.raw.recipe[recipe_name].normal.enabled then
    data.raw.recipe[recipe_name].normal.enabled = enabled[1]
    data.raw.recipe[recipe_name].expensive.enabled = enabled[2]
  end
end
---@param recipe_name string
---@param energy table contains float {normal, expensive}
function casting_recipe_set_energy(recipe_name, energy)
  if data.raw.recipe[recipe_name].normal.energy then
    data.raw.recipe[recipe_name].normal.energy = energy[1]
    data.raw.recipe[recipe_name].expensive.energy = energy[2]
  end
end
---@param recipe_name string
---@param temperature table contains integers {normal, expensive}
function casting_recipe_set_temperature(recipe_name, temperature)
  if data.raw.recipe[recipe_name].normal.ingredients.temperature then
    data.raw.recipe[recipe_name].normal.ingredients.temperature = temperature[1]
    data.raw.recipe[recipe_name].expensive.ingredients.temperature = temperature[2]
  end
end

