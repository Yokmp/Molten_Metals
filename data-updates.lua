
local MoltenIron = {}


local _pattern = {"-ore"}
-- if a fluids temp is lower/higher than the fluid_box settings it can not be used in this machine
local temperatures = { -- {melting-point, boiling-point}
  iron={1500,3000}, copper={1100,2600}, uranium={1100,4100}, titanium={1600,3200}, lead={320,1700}, tungsten={3400,5900}
}


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
-- log(serpent.block(data.raw.resource["iron-ore"].minable))
-- log(data.raw.fluid["crude-oil"].type)
-- assert(1==2, "get_minable_resouces()")

---@param name string ore/item or fluid name
function is_ore(name)
  local _resources = get_minable_resouces()

  for _, table in ipairs(_resources) do
    for _, result in ipairs(table.results) do
      if result.name == name then return true end
    end
  end

  return false
end
-- log(serpent.block(is_ore( "iron-stick" )))
-- log(serpent.block(is_ore( "iron-ore" )))
-- assert(1==2, "is_ore()")

function make_molten_recipe(ore_name)

  if is_ore(ore_name) then
    -- proceed
  end

  for item_name, _ in pairs(data.raw.item) do
    for _, p in ipairs(_pattern) do
      item_name = tostring(item_name)
      local _name = string.gsub(item_name, p, "", 1)

      -- if string.match(tostring(item_name), p) then
        ores[item_name]              = ores[item_name] or {}
        ores[item_name].name         = _name
        ores[item_name].ore          = item_name
        ores[item_name].icon         = get_icon(_name)
        ores[item_name].order        = data.raw.item[item_name].order or ("z[".._name.."]")
        ores[item_name].auto         = false
        ores[item_name].temp_default = 1500
        ores[item_name].temp_max     = 2600
        ores[item_name].capacity     = "0.425KJ"
        ores[item_name].temp_default = temperatures[_name][1] or 1200
        ores[item_name].temp_max     = temperatures[_name][2] or 2500
      -- end

    end
  end
  if #ores == 0 then
    error("functions.lua - get_ores () -> No ores found")
  end
end


log(serpent.block(ores))