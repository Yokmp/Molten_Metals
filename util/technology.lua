
----------------
-- TECHNOLOGY --
----------------

---Creates a new technology
---@param tech_name string
---@param icon_name string
---@param prerequisites table use technology_set_parent()
---@param ingredient table or use technology_add_ingedient()
---@param localized_name? string item-name
---@param count? number
---@param time? number
function molten_metals.new_technology_ext(tech_name, icon_name, prerequisites, ingredient, localized_name, count, time)

  data:extend({
    {
      type = "technology",
      name = tech_name,
      localised_name = {"", {"item-name."..localized_name}, " ", {"item-name.casting"}},
      icons = molten_metals.technology_molten_icon(tech_name, icon_name),
      effects = {},
      prerequisites = prerequisites,
      unit =
      {
        count = count or 75,
        ingredients = {ingredient},
        time = time or 5
      },
      order = "c["..tech_name.."]"
    },
  })
end

---Wrapper for new_technology_ext(), also sets the parent technology
---@param tech_name string
---@param icon_name string
---@param parent_name string
---@param localized_name? string omittable if icon and locale names match
function molten_metals.new_technology(tech_name, icon_name, parent_name, localized_name)
  molten_metals.new_technology_ext(tech_name, icon_name, {}, {}, localized_name or icon_name)
  molten_metals.technology_set_parent(tech_name, parent_name)
end


---Adds a recipe as effect to a technology
---@param technology_name string
---@param recipe_name string
function molten_metals.technology_add_effect(technology_name, recipe_name)
  if data.raw.technology[technology_name] and data.raw.technology[technology_name].effects then
    table.insert(data.raw.technology[technology_name].effects, { type = "unlock-recipe", recipe = recipe_name })
    info("added "..recipe_name.." to ".. technology_name)
  else
    log("Unknown technology or missing key: "..tostring(technology_name))
  end
end


---Returns the prerequisites of a technology
---@param tech_name string
---@return table
function molten_metals.technology_get_prerequisites(tech_name)
  if data.raw.technology[tech_name] then
    return util.table.deepcopy(data.raw.technology[tech_name].prerequisites)
  end
  info("Technology "..tech_name.." has no prerequisites!")
  return {}
end


---Sets the parent of a technology which inherits all prerequisites and ingredients of the parent
---@param tech_name string
---@param parent_name string
---@param use_prerequisites boolean
function molten_metals.technology_set_parent(tech_name, parent_name, use_prerequisites)
  use_prerequisites = use_prerequisites or true
  local prereq = molten_metals.technology_get_prerequisites(parent_name)

  if data.raw.technology[tech_name] and data.raw.technology[parent_name] then
    if use_prerequisites then table.insert(prereq, parent_name) end
    data.raw.technology[tech_name].prerequisites = prereq
    data.raw.technology[tech_name].unit.ingredients = util.table.deepcopy(data.raw.technology[parent_name].unit.ingredients)
  end

end


---Returns icons for technology
---@param tech_name string icon name for technology
---@param item_name string used when tech has no icon
---@param shift? table
---@return table
function molten_metals.technology_molten_icon(tech_name, item_name, shift)

  if ylib.icon.icons["Molten_Metals"][tech_name] then
    return {ylib.icon.icons:get("Molten_Metals", tech_name)}
  end
  local icon = ylib.icon.get_item_icon(item_name)
  local drop = ylib.icon.icons:get("Molten_Metals", "molten-drop-tech")

  icon.scale = 1
  icon.shift = shift or {0,5}
  drop.scale = icon.icon_size/drop.icon_size
  return { icon, drop }
end
