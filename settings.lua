local ores = {"iron-ore", "copper-ore", "stone", "uranium-ore"}

-- brevven
if mods["bzaluminum"] then
  table.insert(ores, "aluminum-ore")
end
if mods["bztitanium"] then
  table.insert(ores, "titanium-ore")
end
if mods["bzlead"] then
  table.insert(ores, "lead-ore")
end
if mods["bztungsten"] then
  table.insert(ores, "tungsten-ore")
end
-- SILICA?


for i, name in ipairs(ores) do
data:extend({
  {
    type = "bool-setting",
    name = "ymm-use-"..name,
    setting_type = "startup",
    default_value = true,
    order = "d"..i,
    localised_name = {"", "[item="..name.."]", " - ", {"item-name."..name}, " ", {"item-name.smelting"}},
    -- localised_description = {"", {"item-name.smelts"}, " ",
    --                              {"item-name."..name}, " ",
    --                              {"item-name.into"}, " ",
    --                              {"item-name.molten"}, " ",
    --                              {"item-name."..name},},
  }
})
end
-- hot-barrel-symbol
local autofill = {
    type = "bool-setting",
    name = "ymm-allow-barreling",
    localised_name = {"", "[img=hot-barrel-symbol]", " - ", {"mod-setting-name.ymm-allow-barreling"}},
    setting_type = "startup",
    default_value = false,
    order = "aa",
    hidden = true
  }

if mods["Fluid_Mixer"] then
  autofill.hidden = false
end

data:extend({
  autofill,
  {
    type = "bool-setting",
    name = "ymm-fp-workaround",
    localised_name = {"", "[img=info]", " - Workaround: ", {"mod-setting-name.ymm-fp-workaround"}},
    localised_description = {"", "This is a workaround for some mods like [font=default-boldFactory Planner[/font] which don't work well with temperatures on fluids."},
    setting_type = "startup",
    default_value = false,
    order = "ab"
  },
  {
    type = "bool-setting",
    name = "ymm-reset-effects",
    localised_name = {"", "[img=info]", " - Reset technology effects"},
    localised_description = {"", "Unlock all recipes from already researched technologies again.\nUse this [font=default-bold]ONLY[/font] if you add this mod to an already existing save or if you run into some kind of deadlock.\n\n[color=red]Disable this option after loading and saving your game.[/color]"},
    setting_type = "startup",
    default_value = false,
    order = "ac"
  },
  {
    type = "bool-setting",
    name = "ymm-steam-ore-temp",
    localised_name = {"", "[fluid=steam]", " - ", {"mod-setting-name.ymm-steam-ore-temp"}},
    setting_type = "startup",
    default_value = false,
    order = "ba"
  },
  {
    type = "bool-setting",
    name = "ymm-enable-slag",
    localised_name = {"", "[item=slag-stone]", " - ", {"mod-setting-name.ymm-enable-slag"}},
    setting_type = "startup",
    default_value = true,
    order = "bb"
  },
  {
    type = "bool-setting",
    name = "ymm-replace-steel-furnace",
    localised_name = {"", "[item=steel-furnace]", " - ", {"mod-setting-name.ymm-replace-steel-furnace"}},
    setting_type = "startup",
    default_value = true,
    order = "c"
  },
  {
    type = "bool-setting",
    name = "ymm-replace-electric-furnace",
    localised_name = {"", "[item=electric-furnace]", " - ", {"mod-setting-name.ymm-replace-electric-furnace"}},
    setting_type = "startup",
    default_value = true,
    order = "d"
  },
  {
    type = "bool-setting",
    name = "ymm-use-old-icons",
    localised_name = {"", "[img=basic-caster-old]", " - ", {"mod-setting-name.ymm-use-old-icons"}},
    setting_type = "startup",
    default_value = false,
    order = "e"
  },
})


-- local _settings
-- for name, value in pairs(settings.startup) do
--     if string.find(tostring(name), "ymm-", 0, true) then
--         -- name = string.match(name, "^%w+%-%w+%-(%w+)")
--         local _t = {}
--         for word in string.gmatch(name, "[^-]+") do
--             table.insert(_t, tonumber(word) or word)
--         end
--         name = _t[4] and _t[3].."-".._t[4] or _t[3]
--         _settings[tostring(name)] = value.value
--     end
-- end
-- log(serpent.block(_settings))
-- error()