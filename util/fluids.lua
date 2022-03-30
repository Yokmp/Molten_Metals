
local autofill = settings.startup["ymm-allow-barreling"].value

function make_molten_fluid(ore_name)

  -- log(serpent.block(icons.icons["molten-"..ore_name]))
  -- log(serpent.block(icons.icons[ore_name]))
  -- log(serpent.block(yutil.get_composed_icon(ore_name)))

  data:extend({{
    type = "fluid",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name.molten"}, " ", {"item-name."..ore_name}},
    -- icons = {icons.icons["molten-"..ore_name]},
    icons = get_composed_icon(ore_name),
    default_temperature = yutil.ore_definition(ore_name).min,
    max_temperature = yutil.ore_definition(ore_name).max,
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    order = "m[molten-"..ore_name.."]",
    auto_barrel = autofill
  }})
end


-- log(serpent.block(data.raw.fluid["molten-iron-ore"]))

-- error("FLUID")