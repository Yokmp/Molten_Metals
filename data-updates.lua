-- require('__debugadapter__/debugadapter.lua')

logging = true

---create the categories for molten metals
categories = {smelting="ymm_smelting", casting="ymm_casting"}
data:extend({
  { type = "recipe-category", name = categories.smelting, },
  { type = "recipe-category", name = categories.casting },
})


require("util.functions")
blacklist = {
  ores = {"coal"},
  recipes = {"concrete"}
}
ore = get_minable_resouces()
yutil = require("util.util")

require("util.fluids")
require("util.recipe")
require("util.technology")

require("prototypes.vanilla.entities")
require("prototypes.vanilla.machines")
require("prototypes.vanilla.slag")
require("prototypes.vanilla.technology")
require("prototypes.vanilla.create")



require("prototypes.mods.bz-mods")
