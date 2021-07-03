local yutil = require("prototypes.util")
local autofill = settings.startup["ymm-allow-barreling"].value
local _ore_names = {"iron", "copper", "stone", "uranium"}

local function make_molten_fluid(name)

  data:extend({{
    type = "fluid",
    name = "molten-"..name,
    icons = yutil.get_icons(name),
    default_temperature = yutil.temperatures[name][1],
    max_temperature = yutil.temperatures[name][2],
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    order = "m[molten-"..name.."]",
    auto_barrel = autofill
  }})
end

for _, name in ipairs(_ore_names) do
  make_molten_fluid(name)
end


-- data:extend({
--   {
--     type = "fluid",
--     name = "acidic-water",
--     icon = "__Molten_Metals__/graphics/icons/acidic-water.png",
--     icon_size = 64, icon_mipmaps = 4,
--     default_temperature = 80,
--     max_temperature = 100,
--     heat_capacity = "0.1KJ",
--     base_color = color.acidwater.base,
--     flow_color = color.acidwater.flow,
--     order = "z"
--   },
-- })
