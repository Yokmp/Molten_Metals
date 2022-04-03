
local autofill = settings.startup["ymm-allow-barreling"].value

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


function get_fluid_icon(fluid_name)
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
        icon = fluid.icons
      end
    end
    return icon
  end


function new_mixed_fluid(fluid_base, fluid_mix)
  local fluid_name = fluid_base.."-"..fluid_mix.."-mix"
  local temp_min = math.max(yutil.ore_definition(fluid_base).min, yutil.ore_definition(fluid_mix).min)
  local temp_max = math.max(yutil.ore_definition(fluid_base).max, yutil.ore_definition(fluid_mix).max)
  local icon_base = get_fluid_icon(fluid_base)
  local icon_mix = get_fluid_icon(fluid_mix)
  icon_base.shift = {-6,-4}
  icon_mix.shift = {6,-4}


  local mixed_fluid = {
    type = "fluid",
    name = fluid_name,
    localised_name = {"", {"fluid-name."..fluid_base}, "-", {"fluid-name."..fluid_mix}, " ", {"fluid-name.mix"}},
    icons = {icon_base, icon_mix},
    default_temperature = temp_min,
    max_temperature = temp_max,
    heat_capacity = "0.425KJ",
    base_color = mix_tints(data.raw.fluid[fluid_base].base_color, data.raw.fluid[fluid_mix].base_color),
    flow_color = mix_tints(data.raw.fluid[fluid_base].flow_color, data.raw.fluid[fluid_mix].flow_color),
    order = "mx["..fluid_name.."]",
    auto_barrel = autofill
  }
  data:extend({mixed_fluid})
end
new_mixed_fluid("crude-oil", "heavy-oil")
log(serpent.block(data.raw.fluid["crude-oil-heavy-oil-mix"]))
-- error("new_mixed_fluid()")

data:extend({
  {
    type = "recipe",
    name = "crude-oil-heavy-oil-mix",
    energy_required = 2,
    enabled = true,
    category = "chemistry",
    ingredients = {
      {type="fluid", name="heavy-oil", amount=20},
      {type="fluid", name="crude-oil", amount=20}
    },
    results = {
      {type = "fluid", name = "crude-oil-heavy-oil-mix", amount = 40, temperature = 1100}
    },
  },
})



-- ---Returns a list of all fluids
-- ---@param filter? table
-- ---@return table
-- function get_fluids(filter)
--   filter = filter or {""}
--   local list = {}
--   for _, fluid in pairs(data.raw.fluid) do
--     for _, f in ipairs(filter) do
--       if string.find(fluid.name, f) then
--         list[#list+1] = fluid.name
--       end
--     end
--   end
--   return list
-- end


-- --get_mixed_fluids
-- list = get_fluids({"oil", "lubricant"})
-- fluids={}
-- index = 1
-- for index, base in pairs(list) do
--   for i = index, #list, 1 do
--     if base ~= list[i] then
--       local _bm = {data.raw.fluid[base].base_color, data.raw.fluid[list[i]].base_color}
--       local _bf = {data.raw.fluid[base].flow_color, data.raw.fluid[list[i]].flow_color}
--       fluids[base.."-"..list[i].."-mix"] = {
--         fluid_base = base,
--         fluid_mix = list[i],
--         base_color = mix_tints(_bm[1], _bm[2]), --this doesn't belong here
--         flow_color = mix_tints(_bf[1], _bf[2])  --nut it's ok for now
--       }
--     end
--   end
--   index = index + 2 --just create duplicates but set them as hidden and the result to the same?
-- end
-- log("Fluid mixtures generated: "..tostring(#list*(#list-1)/2).."/"..tostring(#fluids))
-- -- log(serpent.block(fluids))



-- function new_fluid_mix_recipe(fluid)
--   local base_name = fluid.fluid_base
--   local mix_name = fluid.fluid_mix
--   local fluid_name = base_name.."-"..mix_name.."-mix"
--   local temp_min = math.max(yutil.ore_definition(base_name).min, yutil.ore_definition(mix_name).min)
--   local temp_max = math.max(yutil.ore_definition(base_name).max, yutil.ore_definition(mix_name).max)

--   -- data:extend({
-- return    {
--     type = "fluid",
--     name = fluid_name,
--     localised_name = {"", {"fluid-name."..base_name}, "-", {"fluid-name."..mix_name}, "-", {"item-name.mix"}},
--     icons = {icons:get("missing")}, --get_fluid_icon(size, scale, shift)
--     default_temperature = temp_min,
--     max_temperature = temp_max,
--     heat_capacity = "0.425KJ",
--     base_color = fluid.base_color,
--     flow_color = fluid.flow_color,
--     order = "mx["..fluid_name.."]",
--     auto_barrel = autofill
--   }
-- -- })
-- end
-- -- log(serpent.block(fluids))
-- log(serpent.block(new_fluid_mix_recipe(fluids["crude-oil-heavy-oil-mix"])))

-- error("get_fluids")
