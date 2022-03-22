local resources = {"iron-ore", "copper-ore", "stone", "uranium-ore"}
for i, name in ipairs(resources) do
    data:extend({
        {
            type = "bool-setting",
            name = "ymm-use-"..name,
            setting_type = "startup",
            default_value = false,
            order = "d"..i,
            localised_name = {"item-name."..name},
            localised_description = {"[item="..name.."]"},
        }
    })
end


data:extend({
  {
      type = "bool-setting",
      name = "ymm-allow-barreling",
      setting_type = "startup",
      default_value = false,
      order = "a"
  },
  {
      type = "bool-setting",
      name = "ymm-enable-slag",
      setting_type = "startup",
      default_value = true,
      order = "b"
  },
  {
      type = "bool-setting",
      name = "ymm-replace-steel-furnace",
      setting_type = "startup",
      default_value = true,
      order = "c"
  },
  {
      type = "bool-setting",
      name = "ymm-replace-electric-furnace",
      setting_type = "startup",
      default_value = true,
      order = "d"
  },
})