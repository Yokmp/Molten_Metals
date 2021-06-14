local _pattern = {"-ore"}
local mod_name = "__Molten_Metals__"
local prefix = "molten-"



local function get_icon(name)
  local icon_path = mod_name.. "/graphics/icons/" ..prefix
  local icons = { "iron", "copper", "uranium",}
  local ext = ".png"
  for _,v in ipairs(icons) do
    if v == name then return icon_path..v..ext end
  end
  return mod_name.. "/graphics/icons/missing-icon.png"

end
-- log("missing-icon: "..get_icon("test"))
-- log("molten-iron: "..get_icon("molten-iron"))
-- assert(1==2, " D I E")

local function get_ores()
  local t = {}
  for _, value in pairs(data.raw.item) do
    for _, p in ipairs(_pattern) do
      if string.match(tostring(value.name), p) then
        t[value.name] = t[value.name] or {}
        local name = string.gsub(value.name, p, "", 1)
        t[value.name].name = name
        t[value.name].ore = value.name
        t[value.name].icon = get_icon(name)
        t[value.name].order = data.raw.item[value.name].order or "z"
      end
    end
  end
  return t
end
-- log(serpent.block(get_ores()))
-- assert(1 == 2, " D I E")

---create a fluid from all found ores by ``_pattern``
---@param ores table
---@param order? string
---@param temperature? table
---@param bottle? boolean
---@return table fluid
local function make_fluid(ores, temperature, order, bottle)
  local fluids = {}
  temperature = temperature or {}
  for _, v in pairs(ores) do
    local fluid = {
      type = "fluid",
      name = prefix .. v.name,
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
-- log(serpent.block(make_fluid(get_ores())))
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
          {type = "item", name = v.ore, amount = _n.in_amount}
        },
        results = {
          {type = "fluid", name = prefix .. v.name, amount = _n.in_amount*20, temperature = data.raw.item[v.ore].default_temperature or 1200},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.ceil(_n.in_amount*1.5), probability = 0.24}
        }
      },
      expensive = {
        main_product = prefix .. v.name,
        enabled = _e.enabled,
        energy_required = _e.energy_required,
        ingredients = {
          {type = "item", name = v.ore, amount = _e.in_amount}
        },
        results = {
          {type = "fluid", name = prefix .. v.name, amount = _e.in_amount*20, temperature = data.raw.item[v.ore].default_temperature or 1200},
          {type = "item", name = "slag-stone", amount_min = 1, amount_max = math.ceil(_e.in_amount*1.5), probability = 0.24}
        }
      }
    })

  end
  return reciepes
end
log(serpent.block(make_fluidreciepe(get_ores())))
assert(1 == 2, " D I E")


local function add_to_results(scrap_results, recipe, ingredients, mode)
  for _, v in ipairs(ingredients) do
    for i = 1, #_types do
      if string.match(tostring(v[1]), _types[i]) then
        scrap_results[recipe] = scrap_results[recipe] or {}
        scrap_results[recipe][mode] = scrap_results[recipe][mode] or {}
        if mode ~= "results" then
          scrap_results[recipe][mode].results =
              scrap_results[recipe][mode].results or {}
          local scrap = scrap_results[recipe][mode].results[_types[i] ..
                            "-scrap"]
          scrap_results[recipe][mode].results[_types[i] .. "-scrap"] = scrap and
                                                                           scrap +
                                                                           1 or
                                                                           1
        else
          local scrap = scrap_results[recipe][mode][_types[i] .. "-scrap"]
          scrap_results[recipe][mode][_types[i] .. "-scrap"] = scrap and scrap +
                                                                   1 or 1
        end
        break
      end
    end
  end
end
---Returns a table which holds all items and their ingredients. If there is a difficulty it will also be included.
---@return table ``{results = {name = name, amount_min = 1, amount_max = amount}}``
local function get_scrap_results()
  local scrap_results = {}
  for recipe, value in pairs(data.raw.recipe) do

    if value.expensive then
      local insert = {}
      add_to_results(scrap_results, recipe, value.expensive.ingredients, "expensive")
      if scrap_results[recipe] and scrap_results[recipe].expensive then
        for name, amount in pairs(scrap_results[recipe].expensive.results) do
          table.insert(insert, {
            name = name,
            amount_min = 1,
            amount_max = amount,
            probability = 0.24
          })
        end
        scrap_results[recipe].expensive.results = insert
      else
        if debug then log(tostring(recipe) .. ".expensive -> not found") end
        scrap_results[recipe] = nil
      end
    end

    if value.normal then
      local insert = {}
      add_to_results(scrap_results, recipe, value.normal.ingredients, "normal")
      if scrap_results[recipe] and scrap_results[recipe].normal then
        for name, amount in pairs(scrap_results[recipe].normal.results) do
          table.insert(insert, {
            name = name,
            amount_min = 1,
            amount_max = amount,
            probability = 0.24
          })
        end
        scrap_results[recipe].normal.results = insert
      else
        if debug then log(tostring(recipe) .. ".normal -> not found") end
        scrap_results[recipe] = nil
      end
    end

    if value.ingredients then
      local insert = {}
      add_to_results(scrap_results, recipe, value.ingredients, "results")
      if scrap_results[recipe] and scrap_results[recipe].results then
        for name, amount in pairs(scrap_results[recipe].results) do
          table.insert(insert, {
            name = name,
            amount_min = 1,
            amount_max = amount,
            probability = 0.24
          })
        end
        scrap_results[recipe].results = insert
      else
        if debug then log(tostring(recipe) .. ".results -> not found") end
        scrap_results[recipe] = nil
      end
    end

  end
  return scrap_results
end
-- log(serpent.block(data.raw.recipe["iron-gear-wheel"], {comment = false}))
-- log(serpent.block(get_scrap_results()["iron-gear-wheel"], {comment = false}))
-- log(serpent.block(get_scrap_results()["gun-turret"], {comment = false}))
-- assert(1==2, " D I E")