
table.insert( 
  data.raw.technology["uranium-processing"].effects,
  {type = "unlock-recipe", recipe = "molten-uranium"} )
table.insert( 
  data.raw.technology["kovarex-enrichment-process"].effects,
  {type = "unlock-recipe", recipe = "molten-uranium-processing"} )

data:extend({
  --------------------------
  --   SMELTER + CASTER   --
  -- molten ore to plates --
  --------------------------
  {
    type = "technology",
    name = "advanced-material-processing",
    icon_size = 128,
    icon = "__Molten_Metals__/graphics/technology/smelting.png",
    effects =
    {
      -- {
      --   type = "unlock-recipe",
      --   recipe = "steel-furnace"
      -- },
      {
        type = "unlock-recipe",
        recipe = "basic-smelter"
      },
	    {
        type = "unlock-recipe",
        recipe = "basic-caster"
      },
	    {
        type = "unlock-recipe",
        recipe = "molten-iron"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-copper"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-stone"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-iron-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-copper-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-stone-brick"
      },
    },
    -- prerequisites = {"logistic-science-pack"}, -- fluid-handling
    prerequisites = {"steel-processing", "logistic-science-pack"},
    unit =
    {
      count = 75,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-a"
  },
--#region Unused
  ------------------------
  -- SLAG to LANDFILL   --
  -- SLAG to STONEBRICK --
  ------------------------
  -- {
  --   type = "technology",
  --   name = "basic-slag",
  --   icon_size = 128,
  --   icon = "__Molten_Metals__/graphics/technology/slag.png",
  --   effects =
  --   {
  --     {
  --       type = "unlock-recipe",
  --       recipe = "slag-landfill"
  --     },
  --     -- {
  --     --   type = "unlock-recipe",
  --     --   recipe = "slag-brick"
  --     -- }
  --   },
  --   prerequisites = {"advanced-material-processing", "landfill"},
  --   unit =
  --   {
  --     count = 240,
  --     ingredients = {
  --       {"automation-science-pack", 1},
  --       {"logistic-science-pack", 1},
  --       {"chemical-science-pack", 1}
  --     },
  --     time = 20
  --   },
  --   order = "c-a"
  -- },
  ----------------------------
  -- T2: ADVANCED_CASTER    --
  -- ORE to LIQUID ADVANCED --
  -- LIQUID to INGOT        --
  -- INGOT to PLATE         --
  ----------------------------
  -- {
  --   type = "technology",
  --   name = "ingot-casting",
  --   icon_size = 128,
  --   icon = "__Molten_Metals__/graphics/technology/ingot-casting.png",
  --   effects =
  --   {
  --     {
  --       type = "unlock-recipe",
  --       recipe = "molten-iron-ingot"
  --     },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "iron-ingot-plate"
  --     },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "molten-copper-ingot"
  --     },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "copper-ingot-plate"
  --     }
  --   },
  --   prerequisites = {"advanced-material-processing","advanced-electronics", "fluid-handling"},
  --   unit =
  --   {
  --     count = 350,
  --     ingredients = {
  --       {"automation-science-pack", 1},
  --       {"logistic-science-pack", 1},
  --       {"chemical-science-pack", 1},
  --       {"production-science-pack", 1},
  --       {"utility-science-pack", 1}
  --     },
  --     time = 30
  --   },
  --   order = "c-a"
  -- },
  --------------------------
  -- INGOT to ROLL        --
  -- ROLL to PLATE        --
  --------------------------
  -- {
  --   type = "technology",
  --   name = "hot-rolled-metal",
  --   icon_size = 128,
  --   icon = "__Molten_Metals__/graphics/technology/hot-roll.png",
  --   effects =
  --   {
  --     {
  --       type = "unlock-recipe",
  --       recipe = "iron-ingot-sheet"
  --     },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "iron-sheet-plate"
  --     },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "copper-ingot-sheet"
  --     },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "copper-sheet-plate"
  --     }
  --   },
  --   prerequisites = {"ingot-casting","automation-3"},
  --   unit =
  --   {
  --     count = 450,
  --     ingredients = {
  --       {"automation-science-pack", 1},
  --       {"logistic-science-pack", 1},
  --       {"chemical-science-pack", 1},
  --       {"production-science-pack", 1},
  --       {"utility-science-pack", 1},
  --       {"space-science-pack", 1}
  --     },
  --     time = 30
  --   },
  --   order = "c-b"
  -- },
  ------------------------
  -- SLAG to POWDER     --
  -- POWDER to CONCRETE --
  ------------------------
  -- {
  --   type = "technology",
  --   name = "slag-powder",
  --   icon_size = 128,
  --   icon = "__Molten_Metals__/graphics/technology/slag-powder.png",
  --   effects =
  --   {
  --     -- {
  --     --   type = "unlock-recipe",
  --     --   recipe = "slag-powder"
  --     -- },
  --     {
  --       type = "unlock-recipe",
  --       recipe = "slag-stone-concrete"
  --     }
  --   },
  --   prerequisites = {
  --     --"basic-slag", 
  --     "concrete"},
  --   unit =
  --   {
  --     count = 380,
  --     ingredients = {
  --       {"automation-science-pack", 1},
  --       {"logistic-science-pack", 1},
  --       {"chemical-science-pack", 1},
  --       {"production-science-pack", 1}
  --     },
  --     time = 20
  --   },
  --   order = "c-a"
  -- },
  --#endregion
  ------------------------
  --      ADVANCED      --
  -- smelter and caster --
  ------------------------
  {
    type = "technology",
    -- name = "advanced-smelter",
    name = "advanced-material-processing-2",
    icon_size = 128,
    icon = "__Molten_Metals__/graphics/technology/advanced-smelting.png",
    effects =
    {
      -- {
      --   type = "unlock-recipe",
      --   recipe = "electric-furnace"
      -- },
      {
        type = "unlock-recipe",
        recipe = "advanced-smelter"
      },
      {
        type = "unlock-recipe",
        recipe = "advanced-caster"
      },
    },
    -- prerequisites = {
      --"ingot-casting",
      -- "advanced-material-processing-2","productivity-module-2"},
      prerequisites = {"advanced-material-processing", "chemical-science-pack"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-b"
  },
  -----------------
  -- SLAG PELLET --
  --  recycling  --
  -----------------
  {
    type = "technology",
    name = "slag-pellet-recycling",
    icon_size = 128,
    icon = "__Molten_Metals__/graphics/technology/slag-pellet.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "slag-pellet"
      },
      {
        type = "unlock-recipe",
        recipe = "slag-pellet-recycling"
      },
      -- {
      --   type = "unlock-recipe",
      --   recipe = "acidic-water-treatment" -- steel-processing
      -- },
    },
    prerequisites = {
    -- "slag-powder",
    -- "advanced-smelter"
    "sulfur-processing",
    "advanced-material-processing-2"
  },
    unit =
    {
      count = 200,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-c"
  },
  ------------------
  -- IRON CASTING --
  ------------------
  {
    type = "technology",
    name = "iron-casting",
    icon_size = 128,
    icon = "__Molten_Metals__/graphics/technology/iron-casting.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "iron-gear-wheel-casting"
      },
      {
        type = "unlock-recipe",
        recipe = "iron-stick-casting"
      },
      {
        type = "unlock-recipe",
        recipe = "rail-casting" -- steel-processing
      },
    },
    prerequisites = {
    "production-science-pack",
    -- "advanced-material-processing-2"
  },
    unit =
    {
      count = 250,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
      },
      time = 30
    },
    order = "d-b-z"
  }
})
