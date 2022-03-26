
local autofill = settings.startup["ymm-allow-barreling"].value


function make_molten_fluid(ore_name)

  data:extend({{
    type = "fluid",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name.molten"}, " ", {"item-name."..ore_name}},
    icons = {yutil.ore_definition(ore_name, "icon")},
    default_temperature = yutil.ore_definition(ore_name, "temperature").min,
    max_temperature = yutil.ore_definition(ore_name, "temperature").max,
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    order = "m[molten-"..ore_name.."]",
    auto_barrel = autofill
  }})
end
