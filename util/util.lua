
---Will contain more information per ore at some point; Temperature only atm
---@param ore_name string
---@return table
function molten_metals.ore_definition(ore_name)
-- if a fluids temp is lower/higher than the fluid_box settings it can not be used in this machine
-- temperature = {melting-point, boiling-point}
  local definitions = {
    ["missing"]       = {temperature = {min=1100,max=2600}},
    ["iron-ore"]      = {temperature = {min=1500,max=3000}},
    ["copper-ore"]    = {temperature = {min=1100,max=2600}},
    ["stone"]         = {temperature = {min= 800,max=1200}},
    ["uranium-ore"]   = {temperature = {min=1100,max=4100}},
    ["titanium-ore"]  = {temperature = {min=1600,max=3200}},
    ["lead-ore"]      = {temperature = {min= 320,max=1700}},
    ["aluminum-ore"]  = {temperature = {min=660,max=2500}},
    -- ["tungsten-ore"]  = {temperature = {min=3400,max=5900}},
    -- ["platin-ore"]    = {temperature = {min=1800,max=3800}},
    -- ["lithium-ore"]   = {temperature = {min=180,max=1300}},
    -- ["tin-ore"]       = {temperature = {min=230,max=2600}},
    -- ["zinc-ore"]      = {temperature = {min=420,max=900}},
    -- ["aluminium-ore"] = {temperature = {min=660,max=2500}},
    -- ["silver-ore"]    = {temperature = {min=960,max=2200}},
    -- ["gold-ore"]      = {temperature = {min=1100,max=3000}},
  }

  if not definitions[ore_name] then ore_name = "missing" end
  return definitions[ore_name].temperature
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

