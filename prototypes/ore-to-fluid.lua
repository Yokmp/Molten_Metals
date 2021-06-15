
local function recipe_smelting(normal, expensive, bools)
  local recipes = {}
  normal = normal or {}
  expensive = expensive or {}
  bools = bools or {}
  local _n = {
    enabled = normal.enabled or false,
    energy_required = normal.energy_required or 3.2,
    amount = normal.amount or 1 }
  local _e = {
    enabled = expensive.enabled or false,
    energy_required = expensive.energy_required or 3.2,
    amount = expensive.amount or 1 }
  local _b = {
    allow_as_intermediate = bools.allow_as_intermediate or false,
    allow_intermediates = bools.allow_intermediates or false,
    hidden = bools.hidden or false,
    hide_from_player_crafting = bools.hide_from_player_crafting or true,
    show_amount_in_title = bools.show_amount_in_title or true,
    always_show_products = bools.always_show_products or true,
  }
  for k, v in pairs(ores) do

    table.insert(recipes, {
      type = "recipe",
      name = prefix .. v.name,
      category = "ymm_smelting",
      allow_as_intermediate = _b.allow_as_intermediate,
      allow_intermediates = _b.allow_intermediates,
      hidden = _b.hidden,
      hide_from_player_crafting = _b.hide_from_player_crafting,
      show_amount_in_title = _b.show_amount_in_title,
      always_show_products = _b.always_show_products,
      crafting_machine_tint = color.moltenmetal.tint,
      normal = {
        main_product = prefix .. v.name,
        enabled = _n.enabled,
        energy_required = _n.energy_required,  -- vanilla 3.2 at speed 2
        ingredients = {         -- smelterSpeed is 2 and uses 2 ore for molten-iron worth 2 plate -> 1 smelter for 2 casters
          {type = "item", name = v.ore, amount = _n.amount}
        },
        results = {
          {type = "fluid", name = prefix .. v.name, amount = _n.amount*20, temperature = ores[v.ore].temp_default},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.ceil(_n.amount*1.5), probability = 0.24}
        }
      },
      expensive = {
        main_product = prefix .. v.name,
        enabled = _e.enabled,
        energy_required = _e.energy_required,
        ingredients = {
          {type = "item", name = v.ore, amount = _e.amount}
        },
        results = {
          {type = "fluid", name = prefix .. v.name, amount = _e.amount*20, temperature = ores[v.ore].temp_default},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.ceil(_e.amount*1.5), probability = 0.24}
        }
      }
    })

  end
  data:extend(recipes)
  return recipes
end
recipe_smelting()
-- log(serpent.block(recipe_smelting()))
-- assert(1 == 2, " D I E")