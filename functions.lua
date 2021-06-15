mod_name = "__Molten_Metals__"
prefix = "molten-"
local _pattern = {"-ore"}
ores = {}

-- if a molten-ore has no icon it will be ignored, so no fluids, recipes, etc will be generated
function get_icon(name)
  local icon_path = mod_name.. "/graphics/icons/"
  local ext = ".png"
  local icons = {
    iron    = icon_path..prefix.."iron"..ext,
    copper  = icon_path..prefix.."copper"..ext,
    uranium = icon_path..prefix.."uranium"..ext,
  }
  if icons.name then return {true, icons.name}
  else
    log("Error get_icon() :" ..icon_path..prefix..name..ext.. " not found!")
    return {false, mod_name.."/graphics/icons/missing-icon.png"}
  end
end
log("missing-icon: "..get_icon("test"))
log("molten-iron: "..get_icon("molten-iron"))
assert(1==2, " D I E - functions.lua - get_icon()")

local function get_ores()
  -- if a fluids temp is lower/higher than the fluid_box settings it can not be used in this machine
  local temperatures = { -- {melting-point, boiling-point}    MOVE TO FUNCTIONS.LUA
    iron={1500,3000}, copper={1100,2600}, uranium={1100,4100}, titanium={1600,3200}, lead={320,1700}, tungsten={3400,5900}
  }
  for _, value in pairs(data.raw.item) do
    for _, p in ipairs(_pattern) do
      local name = string.gsub(value.name, p, "", 1)
      if string.match(tostring(value.name), p) and get_icon(name)[1] then
        ores[value.name]              = ores[value.name] or {}
        ores[value.name].name         = name
        ores[value.name].ore          = value.name
        ores[value.name].icon         = get_icon(name)[2]
        ores[value.name].order        = data.raw.item[value.name].order or "z"
        ores[value.name].auto         = false
        ores[value.name].temp_default = 1500
        ores[value.name].temp_max     = 2600
        ores[value.name].capacity     = "0.425KJ"
        for key, temp in pairs(temperatures) do
          if string.match(tostring(key), name) then
            ores[value.name].temp_default = temp[1]
            ores[value.name].temp_max = temp[2]
          end
        end
      end
    end
  end
  if #ores == 0 then
    log("functions.lua - get_ores () -> No ores found")
  end
  return ores
end
ores = get_ores()
-- log(serpent.block(ores))
-- assert(1 == 2, " D I E - functions.lua - get_ores()")

function assembler1pipepictures(color)
  local tint = {}
  if type(color) == table then
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

color = {
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

