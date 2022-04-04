local yutil = {}


function yutil.ore_definition(ore_name)
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




---Returns table __t__ with keys for name and amount
---@param t table|string ``lua {string, number?}``
---@return table ``{ name = "name": string, amount = n: integer }``
function yutil.add_pairs(t)

  if type(t) == "table" and t[1] then --they can be empty and would be "valid" until ...
---@diagnostic disable-next-line: undefined-field
    if t.name then return t end       --ignore if it has pairs already
    if type(t[1]) ~= "string" then error(" First value must be 'string'") end
    if type(t[2]) ~= "number" then t[2] = 1 end -- this is risky
    return { name = t[1], amount = t[2] or 1}
  elseif type(t) == "string" then
    log(" Warning: add_pairs("..type(t[1])..", "..type(t[2])..") - implicitly set value - amount = 1")
    return { name = t, amount = 1}
  end

  return t
end


---@return boolean ... returns _false_ if table doesn't exists or is empty, else returns _true_
function yutil.check_table(table)
  if not table then return false end
  if not type(table) == "table" then return false end
  if not next(table) then return false end
  return true
end


---Returns mixed rgb values, big thx to Honktown
---@param t1 color|table
---@param t2 color|table
---@return color|table
function mix_tints(t1, t2)
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


return yutil
