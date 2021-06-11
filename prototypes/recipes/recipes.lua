data:extend({
  --------------------
  -- STEEL SMELTING --
  --------------------
  {
    type = "recipe",
    name = "steel-plate",
    category = "ymm_casting",
    icon = "__base__/graphics/icons/steel-plate.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    main_product = "steel-plate",
    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    always_show_products = true,
    crafting_machine_tint = {
      primary = {r = 249/255, g = 137/255, b = 32/255, a = 0},    -- boiling
      secondary = {r = 230/255, g = 125/255, b = 125/255, a = 0}, -- mask
      tertiary = {r = 230/255, g = 125/255, b = 125/255, a = 0}   -- window
    },
    normal =
    {
      enabled = false,
      energy_required = 16,
      ingredients = {
        -- {"iron-plate", 5},
        {type = "fluid", name = "molten-iron", amount = 100, temperature = 1500},
        {type = "fluid", name = "waste-water", amount = 40}
      },
      results = {
        {type = "item",  name = "steel-plate", amount = 1},
        {type = "fluid", name = "steam", amount = 20, temperature = 165}
      },
    },
    expensive =
    {
      enabled = false,
      energy_required = 32,
      ingredients = {
        -- {"iron-plate", 10},
        {type = "fluid", name = "molten-iron", amount = 100, temperature = 1500},
        {type = "fluid", name = "waste-water", amount = 40}
      },
      results = {
        {type = "item",  name = "steel-plate", amount = 1},
        {type = "fluid", name = "steam", amount = 20, temperature = 165}
      },
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
  energy_required = 3,
  enabled = false,
  main_product = "water",
  ingredients =
  {
    {type = "fluid", name = "waste-water", amount = 80}
  },
  results=
  {
    {type = "fluid", name = "sulfuric-acid", amount = 20},
    {type = "fluid", name = "water", amount = 60}
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
