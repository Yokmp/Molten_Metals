data:extend({
  --------------------
  -- STEEL SMELTING --
  --------------------
  {
    type = "recipe",
    name = "steel-plate",
    category = "ymm_casting",

    -- icon = "__base__/graphics/icons/steel-plate.png",
    -- icon_size = 64, icon_mipmaps = 4,
    -- subgroup = "raw-material",
    -- main_product = "steel-plate",

    allow_as_intermediate = false,
    allow_intermediates = false,
    hidden = false,
    hide_from_player_crafting = true,
    always_show_products = true,
    crafting_machine_tint = moltenmetaltint(),
    normal =
    {
      main_product = "steel-plate",
      enabled = false,
      energy_required = 8,
      ingredients = {
        -- {"iron-plate", 5},
        {type = "fluid", name = "molten-iron", amount = 100, temperature = 1500},
        {type = "fluid", name = "water", amount = 200}
      },
      results = {
        {type = "item",  name = "steel-plate", amount = 1},
        {type = "fluid", name = "steam", amount = 100, temperature = 165}
      },
    },
    expensive =
    {
      main_product = "steel-plate",
      enabled = false,
      energy_required = 16,
      ingredients = {
        -- {"iron-plate", 10},
        {type = "fluid", name = "molten-iron", amount = 100, temperature = 1500},
        {type = "fluid", name = "water", amount = 200}
      },
      results = {
        {type = "item",  name = "steel-plate", amount = 1},
        {type = "fluid", name = "steam", amount = 100, temperature = 165}
      },
    }
  },
  {
    type = "recipe",
    name = "iron-gear-wheel-casting",
    category = "ymm_casting",
    allow_as_intermediate = true, -- can be used in handcrafting?
    allow_intermediates = false,  -- can be handcrafted?
    hidden = false,
    hide_from_player_crafting = true, -- hidden in player screen?
    always_show_products = true,
    show_amount_in_title = true,
    crafting_machine_tint = moltenmetaltint(),
    normal = {
      main_product = "iron-gear-wheel",
      enabled = false,
      energy_required = 1, -- 0.5 at speed 0.5 - 0.75 - 1.25
      ingredients = {
        --{"iron-plate", 2},
        {type = "fluid", name = "molten-iron", amount = 80, temperature = 1500},
        {type = "fluid", name = "water", amount = 160}
      },
      results = {
        {type = "item",  name = "iron-gear-wheel", amount = 2},
        {type = "fluid", name = "steam", amount = 80, temperature = 165}
      },
    },
    expensive =
    {
      main_product = "iron-gear-wheel",
      enabled = false,
      energy_required = 1, -- 0.5 at speed 0.5 - 0.75 - 1.25
      ingredients = {
        --{"iron-plate", 4},
        {type = "fluid", name = "molten-iron", amount = 160, temperature = 1500},
        {type = "fluid", name = "water", amount = 320}
      },
      results = {
        {type = "item",  name = "iron-gear-wheel", amount = 2},
        {type = "fluid", name = "steam", amount = 80, temperature = 165}
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
  crafting_machine_tint = color.acidwater.tint
},
})
