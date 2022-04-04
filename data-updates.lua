-- require('__debugadapter__/debugadapter.lua')

logging = true

---create the categories for molten metals
categories = {smelting="ymm_smelting", casting="ymm_casting"}
data:extend({
  { type = "recipe-category", name = categories.smelting, },
  { type = "recipe-category", name = categories.casting },
})

--//TODO migration or "what if advanced-material-processing(-2) is aready researched?"

require("util.icons")
yutil = require("util.util")
require("util.functions")
blacklist = {
  ores = {"coal"},
  recipes = {"concrete"}
}
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


new_mixed_fluids_and_recipes({"molten"})