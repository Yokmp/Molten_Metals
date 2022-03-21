-- require('__debugadapter__/debugadapter.lua')

---create the categories for molten metals
categories = {smelting="ymm_smelting", casting="ymm_casting"}
data:extend({
  { type = "recipe-category", name = categories.smelting, },
  { type = "recipe-category", name = categories.casting },
})

require("functions")
require("prototypes.item.machines")
require("prototypes.item.slag")
require("prototypes.item.fluids")

require("prototypes.entity.entities")

require("prototypes.recipes.machines")
require("prototypes.recipes.slag")
require("prototypes.recipes.copper")
require("prototypes.recipes.iron")
require("prototypes.recipes.stone")
require("prototypes.recipes.uranium")

require("prototypes.technology.molten-metals")

-- local ore_list = {"iron-ore", "copper-ore", "stone", "uranium-ore"}

--[[
  get a list of all basic-solid ores (done in functions.lua)

  NO automation of the whole process as there arte to many edge cases when mods are involved

  generate a recipe for the molten ores
  generate a recipe for casting
  - get every item which uses the ores as ingredients (could be hard if a mod uses them for like refining)
  - generate the recipe
  handle slag

  replace the iron furnace with the new one
  add caster machines
  modify the technologies
  - write some functions to do that (no automation)
]]

