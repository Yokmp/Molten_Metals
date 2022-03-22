
if settings.startup["ymm-replace-steel-furnace"].value then
  data.raw.item["steel-furnace"].flags = {"hidden"}
  data.raw["furnace"]["stone-furnace"].next_upgrade = "basic-smelter"
end
if settings.startup["ymm-replace-steel-furnace"].value then
  data.raw.item["electric-furnace"].flags = {"hidden"}
end

data:extend({
  --------------
  -- MACHINES --
  --------------
  {
    type = "item",
    name = "basic-smelter",
    icon = "__Molten_Metals__/graphics/icons/basic-smelter.png",
    icon_size = 64, icon_mipmaps = 4,
    group = "furnace",
    subgroup = "smelting-machine",
    order = "b[basic-smelter]",
    place_result = "basic-smelter",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-smelter",
    icon = "__base__/graphics/icons/electric-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    group = "furnace",
    subgroup = "smelting-machine",
    order = "c[advanced-smelter]",
    place_result = "advanced-smelter",
    stack_size = 50
  },
  {
    type = "item",
    name = "basic-caster",
    icon = "__Molten_Metals__/graphics/icons/basic-caster.png",
    icon_size = 32,
    subgroup = "production-machine",
    order = "c[basic-caster]",
    place_result = "basic-caster",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-caster",
    icon = "__Molten_Metals__/graphics/icons/advanced-caster.png",
    icon_size = 32,
    subgroup = "production-machine",
    order = "d[advanced-caster]",
    place_result = "advanced-caster",
    stack_size = 50
  },
})
