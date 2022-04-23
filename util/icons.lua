--icon table

ylib.icon.icons:add("Molten_Metals", "graphics/technology", "hot-barrel-tech", 128, 0 , 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "molten-drop-tech", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "smelting", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "advanced-smelting", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "iron-casting", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "slag-tech", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "slag-pellet-tech", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "slag-powder-tech", 128, 0, 1)

ylib.icon.icons:add("Molten_Metals", "graphics/icons", "basic-caster-old", 32, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "advanced-caster-old", 32, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "slag-brick", 32, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "slag-concrete", 32, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "slag-pellet", 32, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "slag-powder", 32, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "slag-stone", 32, 0, 1)

ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-iron-ore", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-copper-ore", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-stone", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-uranium-ore", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-base", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-drop", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "basic-caster_b", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "advanced-caster", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "basic-smelter", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "advanced-smelter", 64, 4, 0.5)

ylib.icon.icons:alias("Molten_Metals", "iron-ore", "Molten_Metals", "molten-iron-ore")
ylib.icon.icons:alias("Molten_Metals", "copper-ore", "Molten_Metals", "molten-copper-ore")
ylib.icon.icons:alias("Molten_Metals", "stone", "Molten_Metals", "molten-stone")
ylib.icon.icons:alias("Molten_Metals", "uranium-ore", "Molten_Metals", "molten-uranium-ore")


ylib.icon.icons:add("Molten_Metals", "graphics/technology", "aluminium-casting", 128, 0, 1)
ylib.icon.icons:add("Molten_Metals", "graphics/technology", "lead-casting", 128, 0, 1)

ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-aluminium-ore", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-lead-ore", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-titanium-ore", 64, 4, 0.5)
ylib.icon.icons:add("Molten_Metals", "graphics/icons", "molten-tungsten-ore", 64, 4, 0.5)

ylib.icon.icons:alias("Molten_Metals", "aluminum-ore", "Molten_Metals", "molten-aluminium-ore")
ylib.icon.icons:alias("Molten_Metals", "lead-ore", "Molten_Metals", "molten-lead-ore")
ylib.icon.icons:alias("Molten_Metals", "titanium-ore", "Molten_Metals", "molten-titanium-ore")
ylib.icon.icons:alias("Molten_Metals", "tungsten-ore", "Molten_Metals", "molten-tungsten-ore")


-- for key, value in pairs(ylib.icon.icons) do
--   if type(value) ~= "function" then
--     for k, _ in pairs(value) do
--       log(serpent.block({key, k}))
--     end
--   end
-- end


---Returns a table containing icon definitions
---@param icon_top icon|string use ylib.icon.icons:get() if possible, can work on strings
---@param icon_bottom? icon defaults to molten_drop (based on icon_top.icon_size)
---@param shift? table default ``{{0,0}, {0,5}}``
function molten_metals.get_composed_icon(icon_top, icon_bottom, scale, shift) --//TODO util.combine_icons()
  scale = scale or 0.5
  shift = shift or 0

  if type(icon_top) == "string" then
    icon_top = ylib.icon.get_item_icon(icon_top) or ylib.icon.icons:get(icon_top) --//*FIXME drop scaling, should consider making custom icons per metal
  end

  local function determine_icon_by_type()
    if icon_top.icon_size <= 96 then return ylib.icon.icons:get("molten_drop")
    else return ylib.icon.icons:get("molten_drop_tech") end
  end

  icon_top.scale = icon_top.scale and icon_top.scale-0.2 or 0.6
  icon_top.scale = icon_top.scale*scale
  icon_top.shift = {0,0-shift}
  icon_bottom = icon_bottom or determine_icon_by_type()
  icon_bottom.scale = (icon_bottom.icon_size/icon_top.icon_size)*(scale-0.2)
  icon_bottom.shift = {0,0+shift}

  return {icon_top, icon_bottom}
end



data:extend({
  {
    type = "sprite",
    name = "hot-barrel-symbol",
    filename = "__Molten_Metals__/graphics/icons/hot-barrel-symbol.png",
    priority = "extra-high",
    width = 64,
    height = 64,
    shift = {0,0}
  },
})
