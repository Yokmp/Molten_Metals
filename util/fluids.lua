
local autofill = settings.startup["ymm-allow-barreling"].value

---Creates a molten fluid from an ore.
---@param ore_name any
function make_molten_fluid(ore_name)
  local icon = icons[ore_name] and {icons:get(ore_name)} or get_composed_icon(ore_name)
  data:extend({{
    type = "fluid",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name.molten"}, " ", {"item-name."..ore_name}},
    icons = icon,
    default_temperature = yutil.ore_definition(ore_name).min,
    max_temperature = yutil.ore_definition(ore_name).max,
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    order = "m[molten-"..ore_name.."]",
    auto_barrel = autofill
  }})
end
