
local fluids = {}
for _, v in pairs(ores) do
  local fluid = {
    type = "fluid",
    name = prefix .. v.name,
    icon = v.icon,
    icon_size = 64,
    icon_mipmaps = 4,
    default_temperature = v.temp_default,
    max_temperature = v.temp_max,
    heat_capacity = v.capacity,
    base_color = color.moltenmetal.base,
    flow_color = color.moltenmetal.flow,
    order = v.order,
    auto_barrel = v.auto
  }
  table.insert(fluids, fluid)
end
if fluids then
  log(serpent.block(fluids))
  data:extend(fluids)
  return fluids
else
  log("Error fluid_type() : no fluids found!")
  return {false, mod_name.."/graphics/icons/missing-icon.png"}
end

log(serpent.block(fluids))
assert(1 == 2, " D I E - type-fluids.lua")

-- data:extend({
  -- {
  --   type = "fluid",
  --   name = "molten-iron",
  --   icon = "__Molten_Metals__/graphics/icons/molten-iron.png",
  --   icon_size = 64, icon_mipmaps = 4,
  --   default_temperature = 1500,
  --   max_temperature = 3000,
  --   heat_capacity = "0.425KJ",
  --   base_color = color.moltenmetal.base,
  --   flow_color = color.moltenmetal.flow,
  --   -- pressure_to_speed_ratio = 0.4,
  --   -- flow_to_energy_ratio = 0.59,
  --   order = "a[molten-iron]",
  --   auto_barrel = false
  -- },
  -- {
  --   type = "fluid",
  --   name = "molten-copper",
  --   icon = "__Molten_Metals__/graphics/icons/molten-copper.png",
  --   icon_size = 64, icon_mipmaps = 4,
  --   default_temperature = 1100,
  --   max_temperature = 2600,
  --   heat_capacity = "0.259KJ",
  --   base_color = color.moltenmetal.base,
  --   flow_color = color.moltenmetal.flow,
  --   -- pressure_to_speed_ratio = 0.4,
  --   -- flow_to_energy_ratio = 0.59,
  --   order = "b[molten-copper]",
  --   auto_barrel = false
  -- },
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
-- })
