local yutil = require("prototypes.util")
local autofill = settings.startup["ymm-allow-barreling"].value


function make_molten_fluid(ore_name)

  data:extend({{
    type = "fluid",
    name = "molten-"..ore_name,
    icons = yutil.get_icons(ore_name),
    default_temperature = yutil.temperatures[ore_name][1] or 1100,
    max_temperature = yutil.temperatures[ore_name][2] or 2600,
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    order = "m[molten-"..ore_name.."]",
    auto_barrel = autofill
  }})
end

make_molten_fluid("iron-ore")
make_molten_fluid("copper-ore")
make_molten_fluid("stone")
make_molten_fluid("uranium-ore")


-- data:extend({
--   {
--     type = "fluid",
--     name = "waste-water",
--     icon = "__Molten_Metals__/graphics/icons/waste-water.png",
--     icon_size = 64, icon_mipmaps = 4,
--     default_temperature = 80,
--     max_temperature = 100,
--     heat_capacity = "0.1KJ",
--     base_color = color.wastewater.base,
--     flow_color = color.wastewater.flow,
--     order = "z"
--   },
-- })
