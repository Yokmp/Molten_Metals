require("technology-util")

technology_add_effect("uranium-processing", "molten-uranium-ore")
technology_add_effect("uranium-processing", "molten-uranium-238")
technology_add_effect("kovarex-enrichment-process", "molten-uranium-235")

local replace_steel_furnace = settings.startup["ymm-replace-steel-furnace"].value
local replace_electric_furnace = settings.startup["ymm-replace-steel-furnace"].value

local tech = "advanced-material-processing"
data.raw.technology[tech].icon = "__Molten_Metals__/graphics/technology/smelting.png"
data.raw.technology[tech].icon_size = 128
if replace_steel_furnace then technology_remove_effect(tech, "steel-furnace") end
technology_add_effect(tech, "basic-smelter")
technology_add_effect(tech, "basic-caster")
technology_add_effect(tech, "molten-iron-ore")
technology_add_effect(tech, "molten-copper-ore")
technology_add_effect(tech, "molten-stone")
technology_add_effect(tech, "molten-iron-plate")
technology_add_effect(tech, "molten-copper-plate")
technology_add_effect(tech, "molten-stone-brick")

tech = "advanced-material-processing-2"
data.raw.technology[tech].icon = "__Molten_Metals__/graphics/technology/advanced-smelting.png"
data.raw.technology[tech].icon_size = 128
if replace_electric_furnace then technology_remove_effect(tech, "electric-furnace") end
technology_add_effect(tech, "advanced-smelter")
technology_add_effect(tech, "advanced-caster")

-- log(serpent.block(data.raw.technology["advanced-material-processing-2"]))
-- error("TECHNOLOGY")

data:extend({

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
        recipe = "molten-iron-gear-wheel"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-iron-stick"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-rail" -- steel-processing
      },
      {
        type = "unlock-recipe",
        recipe = "molten-copper-cable"
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
