
local yutil = require("prototypes.util")
local use_slag = settings.startup["ymm-enable-slag"].value


---Creates a smelting recipe, _ore-name_ to _molten-ore-name_
---@param ore_name string also determines the main product
---@param amount_in table {normal, expensive}
---@param amount_out table {normal, expensive}
---@param energy table {normal, expensive}
---@return table
function make_new_smelting_recipe(ore_name, amount_in, amount_out, energy)
  amount_in = amount_in or {2,2}
  amount_out = amount_out or {40,40}
  energy = energy or {3.2,3.2}
  local temperature = yutil.temperatures[ore_name] or 1100

  local recipe =  {
    type = "recipe",
    name = "molten-"..ore_name,
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
      enabled = false,
      energy_required = energy,
      ingredients = {
        {type = "item", name = ore_name, amount = amount_in[1]}
      },
      results = {
        {type = "fluid", name = "molten-"..ore_name, amount = amount_out[1], temperature = temperature[1]}
      }
    },
    expensive = {
      main_product = "molten-"..ore_name,
      enabled = false,
      energy_required = energy[2],
      ingredients = {
        {type = "item", name = ore_name, amount = amount_in[2]}
      },
      results = {
        {type = "fluid", name = "molten-"..ore_name, amount = amount_out[2], temperature = temperature[1]}
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
-- make_new_smelting_recipe( "iron-ore", "iron", {2,2}, {40,40}, {3.2,3.2})
-- log(serpent.block(data.raw.recipe["molten-iron"]))
-- make_new_smelting_recipe( "iron-ore")
-- log(serpent.block(data.raw.recipe["molten-iron-ore"]))
-- assert(1==2, "make_new_smelting_recipe()")


