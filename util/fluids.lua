
local autofill = settings.startup["ymm-allow-barreling"].value

---Creates molten-fluid from ore.
---@param ore_name any
function molten_metals.make_molten_fluid(ore_name)
  local icon = ylib.icon.icons["Molten_Metals"][ore_name] and {ylib.icon.icons:get("Molten_Metals", ore_name)} or molten_metals.get_composed_icon(ore_name)
  local molten_fluid = {
    type = "fluid",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name.molten"}, " ", {"item-name."..ore_name}},
    icons = icon,
    default_temperature = molten_metals.ore_definition(ore_name).melting,
    max_temperature = molten_metals.ore_definition(ore_name).boiling+1,
    gas_temperature = molten_metals.ore_definition(ore_name).boiling,
    heat_capacity = molten_metals.ore_definition(ore_name).heat_capacity,    -- heat_capacity = "0.425KJ",
    emissions_multiplier = molten_metals.ore_definition(ore_name).emissions_multiplier,
    base_color = molten_metals.color.moltenmetal.base,
    flow_color = molten_metals.color.moltenmetal.flow,
    order = "m[molten-"..ore_name.."]",
    auto_barrel = autofill
  }
  data:extend({molten_fluid})

  molten_metals.new_barreling(ore_name, molten_fluid)

  -- Flamethrower Ammo
  local turret = data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids
  table.insert(turret, {damage_modifier = molten_metals.ore_definition(ore_name).melting/1000, type = "molten-"..ore_name})

end


---creates new fill/empty barrel and technology
---@param ore_name string
---@param molten_fluid table
function molten_metals.new_barreling(ore_name, molten_fluid)
  if mods["Fluid_Mixer"] and settings.startup["ymm-allow-barreling"].value then
    local empty_barrel_item = {
      type = "item",
      name = "empty-barrel",
      icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "d[empty-barrel]",
      stack_size = 10
    }

    local icons = {ylib.icon.icons:get("Molten_Metals", "hot-barrel-tech")}
    local prerequisites = {"fluid-handling", "advanced-material-processing"}
    local ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}}
    local tech_name = "hot-barreling"

    fluid_mixer.new_mix_technology(tech_name, icons, prerequisites, ingredients)
    local technology = data.raw.technology[tech_name]

    if fluid_mixer.auto_barrel.can_process_fluids(molten_fluid, technology, empty_barrel_item) then -- no need to check
      fluid_mixer.auto_barrel.process_fluid(molten_fluid, technology, empty_barrel_item)

      data.raw.item["molten-"..ore_name.."-barrel"].icons[4]=ylib.icon.get_item_icon(ore_name)
      data.raw.item["molten-"..ore_name.."-barrel"].icons[4].scale = 0.25
      data.raw.item["molten-"..ore_name.."-barrel"].icons[4].shift = {-6,6}

      local ore_data = data.raw.resource[ore_name]
      if ore_data.icon then
        local ore_icon = {
        icon = ore_data.icon,
        icon_size = ore_data.icon_size,
        icon_mipmaps = ore_data.icon_mipmaps,
        scale = 16.0 / ore_data.icon_size,
        shift = { -8, -8 }
      }
      data.raw.recipe["fill-"..molten_fluid.name.."-barrel"].icons[4] = ore_icon
      data.raw.recipe["empty-"..molten_fluid.name.."-barrel"].icons[4] = ore_icon
      else
        data.raw.recipe["fill-"..molten_fluid.name.."-barrel"].icons[4] = ore_data.icons
        data.raw.recipe["empty-"..molten_fluid.name.."-barrel"].icons[4] = ore_data.icons
      end
    elseif not ylib.util.check_table(data.raw.technology[tech_name].effects) then --remove tech so we don't end up with an empty tech
      data.raw.technology[tech_name] = nil
    end
  end
end