
-- {
--   ["key-name"] = {
--     name = "resource-name",
--     type = "basic-solid",
--     results = {
--       {
--         name = "iron-ore",
--         type = "item"
--       }
--     }
--   }
-- }


---Returns the type
---@param name string
---@return string
function get_type(name)
  local type_name = nil
  if type(name) == "string" then
    local type_list = {
      "ammo", "armor", "capsule", "fluid", "gun", "item", "mining-tool", "repair-tool", "module", "tool",
      "item-with-entity-data", "rail-planner", "item-with-label", "item-with-inventory", "blueprint-book",
      "item-with-tags", "selection-tool", "blueprint", "copy-paste-tool", "deconstruction-item", "upgrade-item",
      "spidertron-remote"
    }
    for _, _t in pairs(type_list) do
      if data.raw[_t][name] then type_name = _t end
    end
  else
    log("Parameter Name is not a string")
  end
  return type_name
end


---returns a table containing all minable recources(*basic-solid only!*); removes the ones specified in the **blacklist**
---@param filter? boolean
---@return table
function get_minable_resouces(filter)
  filter = filter or true
  local minable_resources = {}

  for key, value in pairs(data.raw.resource) do
    minable_resources[key] = {name=key, type=value.category or "basic-solid", results={}}
    if value.minable.result then
      local _name = value.minable.result
      local _type = value.minable.type or "item"
      minable_resources[key].results = {{name=_name, type=_type}}
    end
    if value.minable.results then
      for j, result in ipairs(value.minable.results) do
        minable_resources[key].results[j] = {type=result.type, name=result.name}
      end
    end
  end
  if filter then
    for _, name in ipairs(blacklist.ores) do
      for key, value in pairs(minable_resources) do
        if name == key then -- find isnt strict enough
          minable_resources[key] = nil
        end
        if tostring(value.type) ~= "basic-solid" then
          minable_resources[key] = nil
        end
      end
    end
    return minable_resources
  else
    return minable_resources
  end
end
-- log(serpent.block(get_minable_resouces()))
-- error("get_all_minable_resouces()")


---returns wether or not a given resource is minable
---@param name string ore name
---@param resources? table get_minable_resources()
local function is_ore(name, resources)
  resources = resources or get_minable_resouces()

  for key, table in pairs(resources) do
    for _, result in ipairs(table.results) do -- maybe modded resources have more than 1 result
      if result.name == name then return true end
    end
  end

  return false
end






