--//TODO move table into ylib.icon.icons

---@type icon
icon_prototype = {
    icon = nil,
    icon_size = nil,
    icon_mipmaps = 0,
    scale = 1,
    shift = {0,0},
    tint = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }
  }

-- key = {name, folder, size, mipmaps, scale}
icons = {
  basic_old         = {"basic-caster-old", "icons", 32, 0, 1},
  advanced_old      = {"advanced-caster-old", "icons", 32, 0, 1},
  slag              = {"slag-stone", "icons", 32, 0, 1},
  brick             = {"slag-brick", "icons", 32, 0, 1},
  concrete          = {"slag-concrete", "icons", 32, 0, 1},
  pellet            = {"slag-pellet", "icons", 32, 0, 1},
  powder            = {"slag-powder", "icons", 32, 0, 1},

  molten_iron       = {"molten-iron-ore", "icons", 64, 4, 0.5},
  molten_copper     = {"molten-copper-ore", "icons", 64, 4, 0.5},
  molten_stone      = {"molten-stone", "icons", 64, 4, 0.5},
  molten_uranium    = {"molten-uranium-ore", "icons", 64, 4, 0.5},
  filter            = {"filter", "icons", 64, 4, 0.5},
  molten_bg         = {"molten-base", "icons", 64, 4, 0.5},
  molten_drop       = {"molten-drop", "icons", 64, 4, 0.5},
  missing           = {"missing", "icons", 64, 4, 0.5},
  basic_caster      = {"basic-caster_b", "icons", 64, 4, 0.5},
  advanced_caster   = {"advanced-caster", "icons", 64, 4, 0.5},
  basic_smelter     = {"basic-smelter", "icons", 64, 4, 0.5},
  advanced_smelter  = {"advanced-smelter", "icons", 64, 4, 0.5},
  molten_aluminium  = {"molten-aluminium-ore", "icons", 64, 4, 0.5},
  molten_lead       = {"molten-lead-ore", "icons", 64, 4, 0.5},
  molten_titanium   = {"molten-titanium-ore", "icons", 64, 4, 0.5},
  molten_tungsten   = {"molten-tungsten-ore", "icons", 64, 4, 0.5},
  pipe              = {"pipe", "icons", 64, 4, 0.5},
  pipe_to_ground    = {"pipe-to-ground", "icons", 64, 4, 0.5},

  molten_drop_tech  = {"molten-drop", "technology", 128, 0, 1},
  basic_tech        = {"smelting", "technology", 128, 0, 1},
  advanced_tech     = {"advanced-smelting", "technology", 128, 0, 1},
  casting_tech      = {"iron-casting", "technology", 128, 0, 1},
  slag_tech         = {"slag", "technology", 128, 0, 1},
  pellet_tech       = {"slag-pellet", "technology", 128, 0, 1},
  powder_tech       = {"slag-powder", "technology", 128, 0, 1},

  aluminium_tech    = {"aluminium-casting", "technology", 128, 0, 1},
  lead_tech         = {"lead-casting", "technology", 128, 0, 1},

  ---Returns an icon object, Use ``icons:get(name, ...)``
  ---@param self table icons table
  ---@param name string
  ---@param scale? integer
  ---@param shift? vector
  ---@param tint? color
  ---@return icon
  get = function (self, name, scale, shift, tint)
    local proto = util.copy(icon_prototype)
    name = self[name] and name or "missing"
    proto.icon = "__Molten_Metals__/graphics/"..self[name][2].."/"..self[name][1]..".png" ---@type string
    proto.icon_size = self[name][3] ---@type integer
    proto.icon_mipmaps = self[name][4] ---@type integer
    proto.scale = scale or self[name][5] ---@type number
    proto.shift = shift or icon_prototype.shift ---@type vector
    proto.tint = tint or icon_prototype.tint ---@type color
    return proto
  end,
}

icons["iron-ore"]     = icons.molten_iron
icons["copper-ore"]   = icons.molten_copper
icons["stone"]        = icons.molten_stone
icons["uranium-ore"]  = icons.molten_uranium





---Returns a table containing icon definitions
---@param icon_top icon|string use icons:get() if possible, can work on strings
---@param icon_bottom? icon defaults to molten_drop (based on icon_top.icon_size)
---@param shift? table default ``{{0,0}, {0,5}}``
function molten_metals.get_composed_icon(icon_top, icon_bottom, scale, shift) --//TODO util.combine_icons()
  scale = scale or 0.5
  shift = shift or 0

  if type(icon_top) == "string" then
    icon_top = ylib.icon.get_item_icon(icon_top) or icons:get(icon_top) --//*FIXME drop scaling, should consider making custom icons per metal
  end

  local function determine_icon_by_type()
    if icon_top.icon_size <= 96 then return icons:get("molten_drop")
    else return icons:get("molten_drop_tech") end
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
