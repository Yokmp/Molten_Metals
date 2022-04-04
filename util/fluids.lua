
local autofill = settings.startup["ymm-allow-barreling"].value

---Creates a molten fluid from an ore.
---@param ore_name any
function make_molten_fluid(ore_name)
  data:extend({{
    type = "fluid",
    name = "molten-"..ore_name,
    localised_name = {"", {"item-name.molten"}, " ", {"item-name."..ore_name}},
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


------------------
-- FLUID MIXING --
------------------


---Returns the icon data if a fluid.
---@param fluid_name string
---@return icon
function get_fluid_icon(fluid_name)
  ---@type icon
  local icon
  local fluid = data.raw.fluid[fluid_name]
  if fluid then
    icon = {}
    if fluid.icon then
      icon.icon = fluid.icon
      icon.icon_size = fluid.icon_size
      icon.icon_mipmaps = fluid.icon_mipmaps or 0
      icon.shift = icon.shift or {0,0}
      icon.scale = icon.scale or (32/fluid.icon_size)
      icon.tint = icon.tint or {r=1, g=1, b=1, a=1}
    elseif fluid.icons then
      icon = fluid.icons[1]
    end
  end
  return icon
end


function new_mixed_fluid(fluid_base, fluid_mix)
  local fluid_name = fluid_base.."-"..fluid_mix.."-mix"
  local temp_min = math.min(data.raw.fluid[fluid_base].default_temperature, data.raw.fluid[fluid_mix].default_temperature)
  local temp_max = math.max(data.raw.fluid[fluid_base].max_temperature or temp_min, data.raw.fluid[fluid_mix].max_temperature or temp_min)
  local icon_base = get_fluid_icon(fluid_base)
  local icon_mix = get_fluid_icon(fluid_mix)
  icon_base.shift = {-6,-4}
  icon_mix.shift = {6,-4}


  local mixed_fluid = {
    type = "fluid",
    name = fluid_name,
    localised_name = {"", {"fluid-name."..fluid_base}, "-", {"fluid-name."..fluid_mix}, " ", {"fluid-name.mix"}},
    icons = {icon_base, icon_mix, icons:get("fluid_mixing")},
    default_temperature = temp_min,
    max_temperature = temp_max,
    heat_capacity = "0.425KJ",
    base_color = mix_tints(data.raw.fluid[fluid_base].base_color, data.raw.fluid[fluid_mix].base_color),
    flow_color = mix_tints(data.raw.fluid[fluid_base].flow_color, data.raw.fluid[fluid_mix].flow_color),
    order = "mx["..fluid_name.."]",
    allow_decomposition = false,
    auto_barrel = autofill
  }
  data:extend({mixed_fluid})
end
-- new_mixed_fluid("crude-oil", "heavy-oil")
-- log(serpent.block(data.raw.fluid["crude-oil-heavy-oil-mix"]))
-- error("new_mixed_fluid()")


function new_fluid_mix_recipe(fluid_a, fluid_b, enabled, category, energy)
  local data_a = data.raw.fluid[fluid_a]
  local data_b = data.raw.fluid[fluid_b]
  local temp_a = data_a.default_temperature
  local temp_b = data_b.default_temperature
  local temp_mix = (temp_a + temp_b)/2

data:extend({
  {
    type = "recipe",
    name = fluid_a.."-"..fluid_b.."-mix",
    category = category or "chemistry", --//TODO change to fluid mixer category
    enabled = enabled or false,
    energy_required = energy or nil,
    allow_decomposition = false,
    crafting_machine_tint =
    {
      primary = data_a.base_color, -- fluid
      secondary = data_b.base_color, -- foam
      tertiary = data_a.base_color, -- smoke inner
      quaternary = data_b.base_color, -- smoke outer
    },
    ingredients = {
      {type="fluid", name=fluid_a, amount=20},
      {type="fluid", name=fluid_b, amount=20}
    },
    results = {
      {type = "fluid", name = fluid_a.."-"..fluid_b.."-mix", amount = 40, temperature = temp_mix}
    },
  },
})
end
-- new_fluid_mix_recipe("crude-oil", "heavy-oil", true, "chemistry")
-- log(serpent.block(data.raw.recipe["crude-oil-heavy-oil-mix"]))
-- error("new_fluid_mix_recipe()")


function new_fluid_separation_recipe(fluid_a, fluid_b, enabled, category, energy)
  local mix_recipe = data.raw.recipe[fluid_a.."-"..fluid_b.."-mix"]
  local icon_base = get_fluid_icon(fluid_a)
  local icon_mix = get_fluid_icon(fluid_b)
  category = category or "oil-processing"
  -- if mix_recipe.category == "chemistry" then
  --   category = "oil-processing"
  -- end

  data:extend({
    {
      type = "recipe",
      name = fluid_a.."-"..fluid_b.."-separation",
      icons = {icon_base, icon_mix, icons:get("filter")},
      localised_name = {"", {"fluid-name."..fluid_a}, "-", {"fluid-name."..fluid_b}, " ", {"fluid-name.separation"}},
      category = category or mix_recipe.category, --//TODO change to fluid mixer category
      enabled = enabled or mix_recipe.enabled,
      energy_required = energy or mix_recipe.energy,
      subgroup = "fluid-recipes",
      allow_decomposition = false,
      crafting_machine_tint = mix_recipe.crafting_machine_tint,
      ingredients = mix_recipe.results,
      results = mix_recipe.ingredients
    },
  })
end


---Returns a list of all fluids
---@param filter? table
---@return table
function get_fluids(filter)
  filter = filter or {""}
  local list = {}
  for _, fluid in pairs(data.raw.fluid) do
    for _, f in ipairs(filter) do
      if string.find(fluid.name, f) then
        list[#list+1] = fluid.name
      end
    end
  end
  return list
end


function new_mixed_fluids_and_recipes(pattern)
  list = get_fluids(pattern)
  index = 1
  for index, base in pairs(list) do
    for i = index, #list, 1 do
      if base ~= list[i] then
        new_mixed_fluid(base, list[i])
        new_fluid_mix_recipe(base, list[i], true)
        new_fluid_separation_recipe(base, list[i], true)
      end
    end
    index = index + 2 --just create duplicates but set them as hidden and the result to the same?
  end
end

    --//TODO MOVE TO CREATE
new_mixed_fluids_and_recipes({"oil", "lubricant"})
new_mixed_fluids_and_recipes({"water", "-acid"})
new_mixed_fluids_and_recipes({"-gas", "steam"})
