local _pattern = {"-ore"}
local mod_name = "__Molten_Metals__"
local prefix = "molten-"


-- if a molten-ore has no icon it will be ignored, so no fluids, recipes, etc will be generated
local function get_icon(name)
  local icon_path = mod_name.. "/graphics/icons/" ..prefix
  local icons = { "iron", "copper", "uranium",}
  local ext = ".png"
  for _,v in ipairs(icons) do
    if v == name then return icon_path..v..ext end
  end
  return false

end
-- log("missing-icon: "..get_icon("test"))
-- log("molten-iron: "..get_icon("molten-iron"))
-- assert(1==2, " D I E")

local function get_ores()
  local t = {}
  -- if a fluids temp is lower/higher than the fluid_box settings it can not be used in this machine
  local temperatures = { -- {melting-point, boiling-point}    MOVE TO FUNCTIONS.LUA
    iron={1500,3000}, copper={1100,2600}, uranium={1100,4100}, titanium={1600,3200}, lead={320,1700}, tungsten={3400,5900}
  }
  for _, value in pairs(data.raw.item) do
    for _, p in ipairs(_pattern) do
      local name = string.gsub(value.name, p, "", 1)
      if string.match(tostring(value.name), p) and get_icon(name) then
        t[value.name]       = t[value.name] or {}
        t[value.name].name  = name
        t[value.name].ore   = value.name
        t[value.name].icon  = get_icon(name) --or mod_name.. "/graphics/icons/missing-icon.png"
        t[value.name].order = data.raw.item[value.name].order or "z"
        t[value.name].auto  = false
        t[value.name].temp_default = 1500
        t[value.name].temp_max = 2600
        for key, temp in pairs(temperatures) do
          if string.match(tostring(key), name) then
            t[value.name].temp_default = temp[1]
            t[value.name].temp_max = temp[2]
          end
        end
      end
    end
  end
  return t
end
-- log(serpent.block(get_ores()))
-- assert(1 == 2, " D I E")

---create a fluid from all found ores by ``_pattern``
---@param ores table
---@return table fluid
local function make_fluid(ores)
  local fluids = {}
  temperature = temperature or {}
  for _, v in pairs(ores) do
    local fluid = {
      type = "fluid",
      name = prefix .. v.name,
      icon = v.icon,
      icon_size = 64,
      icon_mipmaps = 4,
      default_temperature = v.temp_default,
      max_temperature = v.temp_max,
      heat_capacity = temperature.capacity or "0.425KJ",
      base_color = color.moltenmetal.base,
      flow_color = color.moltenmetal.flow,
      order = v.order,
      auto_barrel = v.auto
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
  return reciepes
end
-- log(serpent.block(make_fluidreciepe(get_ores())))
-- assert(1 == 2, " D I E")


-- get_ores() = {
--   ["iron-ore"] = {
--     auto = false,
--     icon = "__Molten_Metals__/graphics/icons/molten-iron.png",
--     name = "iron",
--     order = "e[iron-ore]",
--     ore = "iron-ore",
--     temp_default = 1500,
--     temp_max = 3000
--   },
-- }


---Get casting recipes
---@param ingredient string
---@return table
local function get_recipes_by_ingredient(ingredient)
  local recipes = {}
  for recipe, value in pairs(data.raw.recipe) do

    if value.expensive and value.expensive.ingredients then
      if #value.expensive.ingredients == 1 and value.expensive.ingredients[1][1] == ingredient then
        recipes[recipe] = recipes[recipe] or {}
        recipes[recipe].expensive = recipes[recipe].expensive or {}
        recipes[recipe].expensive = {value.expensive.ingredients[1][1], value.expensive.ingredients[1][2]}
      end
    end

    if value.normal and value.normal.ingredients then
      if #value.normal.ingredients == 1 and value.normal.ingredients[1][1] == ingredient then
        recipes[recipe] = recipes[recipe] or {}
        recipes[recipe].normal = recipes[recipe].normal or {}
        recipes[recipe].normal = {value.normal.ingredients[1][1], value.normal.ingredients[1][2]}
      end
    end

    if value.ingredients then
      if #value.ingredients == 1 and value.ingredients[1][1] == ingredient then
        recipes[recipe] = recipes[recipe] or {}

        recipes[recipe].ingredients = {value.ingredients}
        if value.result then recipes[recipe].results = {value.result} end
        if type(value.result) == "string" then recipes[recipe].results[2] = 1 end
        if value.results then recipes[recipe].results = {value.results} end


        -- recipes[recipe].simple = recipes[recipe].simple or {}
        -- recipes[recipe].simple.ingredients = {value.ingredients}
        -- if value.result then recipes[recipe].simple.results = {value.result} end
        -- if value.results then recipes[recipe].simple.results = {value.results} end
      end
    end

  end
  return recipes
end
for key, value in pairs(get_ores()) do
  log(serpent.block(get_recipes_by_ingredient(value.ore), {comment = false}))
end
assert(1==2, " D I E")