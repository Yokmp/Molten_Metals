
local yutil = require("prototypes.util")


---Creates a new casting recipe
---@param ore_name string recipe and ingredient name (molten-result-name)
---@param result_name string also sets the main product
---@param amount_in table {normal, expensive}
---@param amount_out table {normal, expensive}
---@param energy table {normal, expensive}
function make_new_casting_recipe(ore_name, result_name, amount_in, amount_out, energy)
  amount_in = amount_in or {20,20}
  amount_out = amount_out or {1,1}
  energy = energy or {1.6,1.6}
  temperature = yutil.temperatures[ore_name] or 1100

data:extend({{
  type = "recipe",
  name = "molten-"..result_name,
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
    enabled = false,
    energy_required = energy[1], -- 1.6 (3.2 at speed 2)
    ingredients = {
      {type = "fluid", name = "molten-"..ore_name, amount = amount_in[1], temperature = temperature[1]},
      {type = "fluid", name = "water", amount = 40}
    },
    results = {
      {type = "item",  name = result_name, amount = amount_out[1]},
      {type = "fluid", name = "steam", amount = 10, temperature = 165}
    }
  },
  expensive = {
    main_product = result_name,
    enabled = false,
    energy_required = energy[2],
    ingredients = {
      {type = "fluid", name = "molten-"..ore_name, amount = amount_in[2], temperature = temperature[1]},
      {type = "fluid", name = "water", amount = 80}
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
-- assert(1==2, "make_new_smelting_recipe()")
