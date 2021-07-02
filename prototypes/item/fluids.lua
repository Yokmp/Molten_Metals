local yutil = require("prototypes.util")

data:extend({
  {
    type = "fluid",
    name = "molten-iron",
    -- icon = "__Molten_Metals__/graphics/icons/missing-icon.png",
    -- icon_size = 64, icon_mipmaps = 4,
    icons = yutil.get_icons("iron"),
    default_temperature = 1500,
    max_temperature = 3000,
    heat_capacity = "0.425KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    -- pressure_to_speed_ratio = 0.4,
    -- flow_to_energy_ratio = 0.59,
    order = "a[molten-iron]",
    auto_barrel = false
  },
  {
    type = "fluid",
    name = "molten-copper",
    icons = yutil.get_icons("stone"),
    -- icon_size = 64, icon_mipmaps = 4,
    default_temperature = 1100,
    max_temperature = 2600,
    heat_capacity = "0.259KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    -- pressure_to_speed_ratio = 0.4,
    -- flow_to_energy_ratio = 0.59,
    order = "b[molten-copper]",
    auto_barrel = false
  },
  {
    type = "fluid",
    name = "molten-uranium",
    icon = "__Molten_Metals__/graphics/icons/molten-uranium.png",
    icon_size = 64, icon_mipmaps = 4,
    default_temperature = 1100,
    max_temperature = 4100,
    heat_capacity = "0.259KJ",
    base_color = yutil.color.moltenmetal.base,
    flow_color = yutil.color.moltenmetal.flow,
    -- pressure_to_speed_ratio = 0.4,
    -- flow_to_energy_ratio = 0.59,
    order = "c[molten-uranium]",
    auto_barrel = false
  },
  -- {
  --   type = "fluid",
  --   name = "acidic-water",
  --   icon = "__Molten_Metals__/graphics/icons/acidic-water.png",
  --   icon_size = 64, icon_mipmaps = 4,
  --   default_temperature = 80,
  --   max_temperature = 100,
  --   heat_capacity = "0.1KJ",
  --   base_color = color.acidwater.base,
  --   flow_color = color.acidwater.flow,
  --   -- pressure_to_speed_ratio = 0.4,
  --   -- flow_to_energy_ratio = 0.59,
  --   order = "z"
  -- },
})
