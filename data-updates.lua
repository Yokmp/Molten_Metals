-- require('__debugadapter__/debugadapter.lua')

molten_metals = {}
---create the categories for molten metals
category = {smelting="ymm_smelting", casting="ymm_casting"}
data:extend({
  { type = "recipe-category", name = category.smelting, },
  { type = "recipe-category", name = category.casting },
})

require("util.icons")
require("util.util")
require("util.functions")
blacklist = { ores = {"coal"}, recipes = {"concrete"} }
ore = get_minable_resouces()

require("util.fluids")
require("util.recipe")
require("util.technology")

require("prototypes.vanilla.entities")
require("prototypes.vanilla.machines")
require("prototypes.vanilla.slag")
require("prototypes.vanilla.technology")
require("prototypes.vanilla.create")

require("prototypes.mods.bz-mods")
