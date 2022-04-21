
local autofill = settings.startup["ymm-allow-barreling"].value

---Creates a molten fluid from an ore.
---@param ore_name any
function make_molten_fluid(ore_name)
  local icon = icons[ore_name] and {icons:get(ore_name)} or molten_metals.get_composed_icon(ore_name)
  local molten_fluid = {
    type = "fluid",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name.molten"}, " ", {"item-name."..ore_name}},
    icons = icon,
    default_temperature = molten_metals.ore_definition(ore_name).min,
    max_temperature = molten_metals.ore_definition(ore_name).max,
    heat_capacity = "0.425KJ",
    base_color = molten_metals.color.moltenmetal.base,
    flow_color = molten_metals.color.moltenmetal.flow,
    order = "m[molten-"..ore_name.."]",
    auto_barrel = autofill
  }
  data:extend({molten_fluid})

  local empty_barrel_item = {
    type = "item",
    name = "hot-barrel",
    icons = {ylib.icon.icons:get("Molten_Metals", "hot-barrel")},
    subgroup = "intermediate-product",
    order = "d[hot-barrel]",
    stack_size = 10
  }

  local technology = data.raw.technology["hot-barrel"]
  if fluid_mixer.auto_barrel.can_process_fluids(molten_fluid, technology, empty_barrel_item) then
    fluid_mixer.auto_barrel.process_fluid(molten_fluid, technology, empty_barrel_item)
  end
end
