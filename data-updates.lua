local _pattern = {"-ore"}
local mod_name = "__Molten_Metals__"

local function get_ores()
  local t = {}
  for _, value in pairs(data.raw.item) do
    for _, p in ipairs(_pattern) do
      if string.match(tostring(value.name), p) then
        t[value.name] = t[value.name] or {}
        local name = string.gsub(value.name, p, "", 1)
        t[value.name].name = name
        t[value.name].ore = value.name
        t[value.name].icon = mod_name .. "/graphics/icons/molten-" ..name.. ".png"
        t[value.name].order = data.raw.item[value.name].order or "z"
      end
    end
  end
  return t
end
local ores = get_ores()
-- log(serpent.block(get_ores()))
-- assert(1 == 2, " D I E")

---create a fluid from all found ores by ``_pattern``
---@param ores table
---@param order? string
---@param temperature? table
---@param bottle? boolean
---@return table fluid
local function make_metalfluid(ores, temperature, order, bottle)
  local fluids = {}
  temperature = temperature or {}
  for _, v in pairs(ores) do
    -- log(serpent.block(key))
    -- log(serpent.block(value))
    local fluid = {
      type = "fluid",
      name = "molten-" ..v.name,
      icon = v.icon,
      icon_size = 64,
      icon_mipmaps = 4,
      default_temperature = temperature.default or 1200,
      max_temperature = temperature.max or 3000,
      heat_capacity = temperature.capacity or "0.425KJ",
      base_color = color.moltenmetal.base,
      flow_color = color.moltenmetal.flow,
      order = v.order,
      auto_barrel = bottle or false
    }
    table.insert(fluids, fluid)
  end

  return fluids
end
-- log(serpent.block(make_metalfluid(ores)))
-- assert(1 == 2, " D I E")

local function make_fluidreciepe(ores, normal, expensive, bools)
  local reciepes = {}
  normal = normal or {}
  expensive = expensive or {}
  bools = bools or {}
  local _n = { enabled = normal.enabled or false, energy_required = normal.energy_required or 3.2, in_amount = normal.in_amount or 1 }
  local _e = { enabled = expensive.enabled or false, energy_required = expensive.energy_required or 3.2, in_amount = expensive.in_amount or 1 }
  local _b = {
    allow_as_intermediate = bools.allow_as_intermediate or false,
    allow_intermediates = bools.allow_intermediates or false,
    hidden = bools.hidden or false,
    hide_from_player_crafting = bools.hide_from_player_crafting or true,
    show_amount_in_title = bools.show_amount_in_title or true,
    always_show_products = bools.always_show_products or true,
  }
  for k, v in pairs(ores) do

    table.insert(reciepes, {
      type = "recipe",
      name = "molten-" ..v.name,
      category = "ymm_smelting",
      allow_as_intermediate = _b.allow_as_intermediate,
      allow_intermediates = _b.allow_intermediates,
      hidden = _b.hidden,
      hide_from_player_crafting = _b.hide_from_player_crafting,
      show_amount_in_title = _b.show_amount_in_title,
      always_show_products = _b.always_show_products,
      crafting_machine_tint = color.moltenmetal.tint,
      normal = {
        main_product = "molten-" ..v.name,
        enabled = _n.enabled,
        energy_required = _n.energy_required,  -- vanilla 3.2 at speed 2
        ingredients = {         -- smelterSpeed is 2 and uses 2 ore for molten-iron worth 2 plate -> 1 smelter for 2 casters
          {type = "item", name = v.ore, amount = _n.in_amount}
        },
        results = {
          {type = "fluid", name = "molten-" ..v.name, amount = _n.in_amount*20, temperature = data.raw.item[v.ore].default_temperature or 1200},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.ceil(_n.in_amount*1.5), probability = 0.24}
        }
      },
      expensive = {
        main_product = "molten-" ..v.name,
        enabled = _e.enabled,
        energy_required = _e.energy_required,
        ingredients = {
          {type = "item", name = v.ore, amount = _e.in_amount}
        },
        results = {
          {type = "fluid", name = "molten-" ..v.name, amount = _e.in_amount*20, temperature = data.raw.item[v.ore].default_temperature or 1200},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.ceil(_e.in_amount*1.5), probability = 0.24}
        }
      }
    })

  end
  return reciepes
end
log(serpent.block(make_fluidreciepe(ores)))
assert(1 == 2, " D I E")
