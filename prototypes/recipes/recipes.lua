data:extend({
  --------------------
  -- STEEL SMELTING --
  --------------------
  {
    type = "recipe",
    name = "steel-plate",
    category = "ymm_casting",
    normal =
    {
      enabled = false,
      energy_required = 16,
      ingredients = {
        -- {"iron-plate", 5},
        {type="fluid", name="molten-iron", amount=40}
      },
      result = "steel-plate"
    },
    expensive =
    {
      enabled = false,
      energy_required = 32,
      ingredients = {
        -- {"iron-plate", 10},
        {type="fluid", name="molten-iron", amount=40}
      },
      result = "steel-plate"
    }
  },
  -----------------
  -- WASTE WATER --
  -----------------
{
  type = "recipe",
  name = "recycle-waste-water",
  category = "chemistry",
  group = "fluids",
  subgroup = "fluid-recipes",
  icon = "__base__/graphics/icons/fluid/water.png",
  icon_size = 64,
  energy_required = 3,
  enabled = false,
  ingredients =
  {
    {type="fluid", name="waste-water", amount=40}
  },
  results=
  {
    {type="fluid", name="sulfuric-acid", amount=10},
    {type="fluid", name="water", amount=30}
  },
  crafting_machine_tint =
  {
    primary = {r = 0.500, g = 0.642, b = 0.261, a = 1.000}, -- #ffa342 ff orange light
    secondary = {r = 0.780, g = 0.322, b = 0.276, a = 1.000}, -- #ffb85f ff orange more light
    tertiary = {r = 0.454, g = 0.559, b = 0.776, a = 1.000}, -- #d9a892 ff skinlike
    quaternary = {r = 0.660, g = 0.224, b = 0.112, a = 1.000}, -- #ff7e45 ff orange bright
  }
},
})
