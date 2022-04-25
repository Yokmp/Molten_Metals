
---Will contain more information per ore at some point; Temperature only atm
---@param ore_name string
---@return table ``{melting=integer, boiling=integer, heat_capacity = "1KJ", emissions_multiplier = number}``
function molten_metals.ore_definition(ore_name)
-- if a fluids temp is lower/higher than the fluid_box settings it can not be used in this machine
-- temperature = {melting-point, boiling-point}
  local definitions = {
    ["missing"]       = {melting=1100, boiling=2400, heat_capacity =    "1KJ", emissions_multiplier = 1  },
    ["iron-ore"]      = {melting=1500, boiling=3000, heat_capacity =  "449KJ", emissions_multiplier = 1.4},
    ["copper-ore"]    = {melting=1100, boiling=2600, heat_capacity =  "385KJ", emissions_multiplier = 2  },
    ["stone"]         = {melting= 800, boiling=1200, heat_capacity =  "225KJ", emissions_multiplier = 0.8},
    ["uranium-ore"]   = {melting=1100, boiling=4100, heat_capacity =  "116KJ", emissions_multiplier = 3.4},
    ["titanium-ore"]  = {melting=1600, boiling=3200, heat_capacity =  "523KJ", emissions_multiplier = 1.1},
    ["lead-ore"]      = {melting= 320, boiling=1700, heat_capacity =  "131KJ", emissions_multiplier = 2  },
    ["aluminum-ore"]  = {melting= 660, boiling=2500, heat_capacity =  "897KJ", emissions_multiplier = 1  },
    ["tungsten-ore"]  = {melting=3400, boiling=5900, heat_capacity =  "138KJ", emissions_multiplier = 1.2},
    ["platin-ore"]    = {melting=1800, boiling=3800, heat_capacity =  "130KJ", emissions_multiplier = 1.5},
    ["lithium-ore"]   = {melting= 180, boiling=1300, heat_capacity = "3482KJ", emissions_multiplier = 2.2},
    ["tin-ore"]       = {melting= 230, boiling=2600, heat_capacity =    "1KJ", emissions_multiplier = 1  },
    ["zinc-ore"]      = {melting= 420, boiling= 900, heat_capacity =  "388KJ", emissions_multiplier = 1  },
    ["aluminium-ore"] = {melting= 660, boiling=2500, heat_capacity =  "897KJ", emissions_multiplier = 1  },
    ["silver-ore"]    = {melting= 960, boiling=2200, heat_capacity =  "235KJ", emissions_multiplier = 1.1},
    ["gold-ore"]      = {melting=1100, boiling=3000, heat_capacity =  "128KJ", emissions_multiplier = 0.6},
  }

  if not definitions[ore_name] then ore_name = "missing" end
  return definitions[ore_name]
end


---Returns mixed rgb values, big thx to Honktown
---@param t1 color|table
---@param t2 color|table
---@return color|table
function molten_metals.mix_tints(t1, t2)
	local tint1 = {t1.r or t1[1] or 0, t1.g or t1[2] or 0, t1.b or t1[3] or 0, t1.a or t1[4]}
	local tint2 = {t2.r or t2[1] or 0, t2.g or t2[2] or 0, t2.b or t2[3] or 0, t2.a or t2[4]}

	for _, tint in pairs({tint1, tint2}) do
		if tint[1] > 1 or tint[2] > 1 or tint[3] > 1 or (tint[4] and tint[4] > 1) then
			for i, c in pairs(tint) do
				tint[i] = c/255
			end
		end
		tint[4] = tint[4] or 1
	end

	return {r=(tint1[1] + tint2[1]) / 2, g=(tint1[2] + tint2[2]) / 2, b=(tint1[3] + tint2[3]) / 2, a=(tint1[4] + tint2[4]) / 2}
end



molten_metals.color = {
  moltenmetal = {
    base = {r = 150 / 255, g =  50 / 255, b = 0},
    flow = {r = 230 / 255, g = 180 / 255, b = 0},
    tint = {
      primary   = {r = 249 / 255, g = 137 / 255, b =  32 / 255, a = 0}, -- boiling
      secondary = {r = 230 / 255, g = 125 / 255, b = 125 / 255, a = 0}, -- mask
      tertiary  = {r = 230 / 255, g = 125 / 255, b = 125 / 255, a = 0}  -- window
    }
  },
  wastewater = {
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

