
if mods["angelsrefining"] then

  local function smelting(item, fluid, result)
    molten_metals.new_smelting_recipe(item, item.."-smelting", result)
    ylib.recipe.replace_result_name("molten-"..item, "molten-"..item, "molten-"..fluid)
    ylib.recipe.set_main_product("molten-"..item, "molten-"..fluid)
--//TODO Molten icon composer
    local icon = ylib.icon.get_item_icon(item)
    icon.scale = 32/icon.icon_size
    icon.shift = {0,-6}
    local drop = ylib.icon.icons:get("Molten_Metals", "molten-drop")
    data.raw.recipe["molten-"..item].icons = {icon, drop}
  end

log(serpent.block(data.raw.item["angels-iron-pebbles"]))


  smelting("angels-iron-pebbles", "iron-ore", "iron-plate")
  ylib.technology.add_effect("advanced-material-processing", "molten-angels-iron-pebbles")
  smelting("angels-iron-nugget", "iron-ore", "iron-plate")
  ylib.technology.add_effect("advanced-material-processing", "molten-angels-iron-nugget")
  smelting("angels-copper-pebbles", "copper-ore", "copper-plate")
  ylib.technology.add_effect("advanced-material-processing", "molten-angels-copper-pebbles")
  smelting("angels-copper-nugget", "copper-ore", "copper-plate")
  ylib.technology.add_effect("ore-floatation", "molten-angels-copper-nugget")


-- adjust results
  local recipe_name = "slag-to-stone"
  data.raw.recipe[recipe_name].hidden = true

  recipe_name = "slag-pellet-recycling"
  data.raw.recipe[recipe_name].results = { --slag-processing-filtering-1
    {type = "fluid", name = "mineral-sludge", amount = 50},
    {type = "fluid", name = "water-yellow-waste", amount = 40}
}


-- adjust technologies
  ylib.technology.add_prerequisites("slag-pellet-recycling", {"slag-processing-2"})

end