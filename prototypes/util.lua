local yutil = {}


-- if a fluids temp is lower/higher than the fluid_box settings it can not be used in this machine
yutil.temperatures = { -- {melting-point, boiling-point}
  ["iron-ore"]={1500,3000}, ["copper-ore"]={1100,2600}, ["stone"]={800,1200}, ["uranium-ore"]={1100,4100}, ["titanium-ore"]={1600,3200}, ["lead-ore"]={320,1700},
  ["tungsten-ore"]={3400,5900}, ["platin-ore"]={1800,3800}, ["lithium-ore"]={180,1300}, ["tin-ore"]={230,2600}, ["zinc-ore"]={420,900}, ["aluminium-ore"]={660,2500},
  ["silver-ore"]={960,2200}, ["gold-ore"]={1100,3000},}


---@param icon_name string Icon name
function yutil.get_icons(icon_name)--, icon_path)
  if type(icon_name) == "string" then
    local icon_path = "__Molten_Metals__/graphics/icons/"

    local icons = {
      missing   = "missing-icon",
      ["iron-ore"]      = "molten-iron-ore",
      ["copper-ore"]    = "molten-copper-ore",
      stone             = "molten-stone",
      ["uranium-ore"]   = "molten-uranium-ore",
      ["titanium-ore"]  = "molten-titanium-ore",
      ["tungsten-ore"]  = "molten-tungsten-ore",
      ["lead-ore"]      = "molten-lead-ore",
    }
    local icon = icons[icon_name] or icons.missing
    -- if icons[icon_name] then
    return  {
      {
        -- icon = icon_path..icons[icon_name]..".png",
        icon = icon_path..icon..".png",
        icon_size = 64, icon_mipmaps = 4,
        scale = 0.5, shift = util.by_pixel(0, 0), tint = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }
      },
    }
    -- else
    --   return  {
    --     {
    --       icon = icon_path..icon_name..".png",
    --       icon_size = 64, icon_mipmaps = 4,
    --       scale = 0.25, shift = {0, -8}, tint = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }
    --     },
    --     {
    --       icon = "__Molten_Metals__/graphics/icons/molten.png",
    --       icon_size = 64, icon_mipmaps = 4,
    --       scale = 0.5, shift = {0, 0}, tint = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }
    --     },
    --     -- { -- layers won't be ordered as defined
    --     --   icon = "__Molten_Metals__/graphics/icons/molten-base.png",
    --     --   icon_size = 64, icon_mipmaps = 4,
    --     --   scale = 0.5, shift = {0, -8}, tint = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }
    --     -- },
    --   }
    -- end

  else
    error("icon_name or path is not a string")
  end
end



---adds name and amount keys to table and returns a new table
---@param _table table ``{string, number?}``
---@return table ``{ name = "name", amount = n }``
function yutil.add_pairs(_table)
  local _t = _table

  if type(_t) == "table" and _t[1] then --they can be empty and would be "valid" until ...
    if _t.name then return _t end       --ignore if it has pairs already
    if type(_t[1]) ~= "string" then error(" First value must be 'string'") end
    if type(_t[2]) ~= "number" then _t[2] = 1 end
    return { name = _t[1], amount = _t[2] or 1}
  elseif type(_t) == "string" then
    log(" Warning: add_pairs("..type(_t[1])..", "..type(_t[2])..") - implicitly set value - amount = 1")
    return { name = _t, amount = 1}
  end

  return _t
end


---@return any any returns _nil_ if table doesn't exists or _false_ if empty else returns _true_
function yutil.check_table(table)
  if not table then return nil end
  if not next(table) then return false end
  return true
end


function yutil.assembler1pipepictures(color)
  local tint = {}
  if type(color) == "table" and next(color) then
    tint = {
      r = color.r or 1,
      g = color.g or 1,
      b = color.b or 1,
      a = color.a or 1
    }
  else
    tint = {r = 1, g = 1, b = 1, a = 1}
  end
  return {
    north = {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-N.png",
      priority = "extra-high",
      width = 71,
      height = 38,
      shift = util.by_pixel(2.25, 13.5),
      scale = 0.5,
      tint = tint
    },
    east = {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-E.png",
      priority = "extra-high",
      width = 42,
      height = 76,
      shift = util.by_pixel(-24.5, 1),
      scale = 0.5,
      tint = tint
    },
    south = {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-S.png",
      priority = "extra-high",
      width = 88,
      height = 61,
      shift = util.by_pixel(0, -31.25),
      scale = 0.5,
      tint = tint
    },
    west = {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-W.png",
      priority = "extra-high",
      width = 39,
      height = 73,
      shift = util.by_pixel(25.75, 1.25),
      scale = 0.5,
      tint = tint
    }
  }
end


yutil.color = {
  moltenmetal = {
    base = {r = 150 / 255, g =  50 / 255, b = 0},
    flow = {r = 230 / 255, g = 180 / 255, b = 0},
    tint = {
      primary   = {r = 249 / 255, g = 137 / 255, b =  32 / 255, a = 0}, -- boiling
      secondary = {r = 230 / 255, g = 125 / 255, b = 125 / 255, a = 0}, -- mask
      tertiary  = {r = 230 / 255, g = 125 / 255, b = 125 / 255, a = 0}  -- window
    }
  },
  acidwater = {
    base = {r = 0.1,  g = 0.44, b = 0.5 },
    flow = {r = 0.86, g = 0.64, b = 0.21},
    tint = {
      primary    = {r = 0.500, g = 0.642, b = 0.261, a = 1.000}, -- #ffa342 ff orange light
      secondary  = {r = 0.780, g = 0.322, b = 0.276, a = 1.000}, -- #ffb85f ff orange more light
      tertiary   = {r = 0.454, g = 0.559, b = 0.776, a = 1.000}, -- #d9a892 ff skinlike
      quaternary = {r = 0.660, g = 0.224, b = 0.112, a = 1.000}  -- #ff7e45 ff orange bright
    }
  }
}


return yutil
