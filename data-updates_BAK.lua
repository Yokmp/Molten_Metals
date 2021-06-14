-- TODO: If a result matches a _type then add that _type instead of result component (eg steel-plate -> steel-scrap NOT iron-scrap)
-- ? add some fluid waste ? -> would require heavy recipe adjustments or additional pipe_connections
-- TODO? maybe make it local and provide an interface if this ever becomes a stand-alone or even public
-- require("lldebugger").start()
debug = true -- use this to spam your log

local MoltenIron = {}

--[[  This table holds the phrases and looks into the recipes with string.match() to find them.
  So iron will match iron-plate and hardenend-iron-plate. Even superironbar would be a match.
  To exclude like copper-plate but still use copper-cables just be more specific. It is also used
  to contruct the scrap-items like ``iron-scrap``.]]
local _types = {"iron", "copper", "steel"} -- , "lead", "titanium", "tungsten"}
--[[  This table holds the result suffix which is then be constructed to ``_types.."-".._results`` (eg iron-plate).
  Like the _types table, this one also goes by priority, so position 1 is taken if possible, if not pos 2 will be checked until
  it runs out of options, then the script will log it and **ignore** the recipe.
  As there will be no recycling of this scrap-item place some kind of fallback at the end. "*plate*"" is a good candidate.]]
local _results = {"plate"} -- , "ingot"}

--- Adds the ingredients (uses difficulty if possible) to the scrap_results table.
---@return table ``{[_types.."-scrap"] = amount}``
local function add_to_results(scrap_results, recipe, ingredients, mode)
  for _, v in ipairs(ingredients) do
    for i = 1, #_types do
      if string.match(tostring(v[1]), _types[i]) then
        scrap_results[recipe] = scrap_results[recipe] or {}
        scrap_results[recipe][mode] = scrap_results[recipe][mode] or {}
        if mode ~= "results" then
          scrap_results[recipe][mode].results =
              scrap_results[recipe][mode].results or {}
          local scrap = scrap_results[recipe][mode].results[_types[i] ..
                            "-scrap"]
          scrap_results[recipe][mode].results[_types[i] .. "-scrap"] = scrap and
                                                                           scrap +
                                                                           1 or
                                                                           1
        else
          local scrap = scrap_results[recipe][mode][_types[i] .. "-scrap"]
          scrap_results[recipe][mode][_types[i] .. "-scrap"] = scrap and scrap +
                                                                   1 or 1
        end
        break
      end
    end
  end
end
---Returns a table which holds all items and their ingredients. If there is a difficulty it will also be included.
---@return table ``{results = {name = name, amount_min = 1, amount_max = amount}}``
function MoltenIron.get_scrap_results()
  local scrap_results = {}
  for recipe, value in pairs(data.raw.recipe) do

    if value.expensive then
      local insert = {}
      add_to_results(scrap_results, recipe, value.expensive.ingredients,
                     "expensive")
      if scrap_results[recipe] and scrap_results[recipe].expensive then
        for name, amount in pairs(scrap_results[recipe].expensive.results) do
          table.insert(insert, {
            name = name,
            amount_min = 1,
            amount_max = amount,
            probability = 0.24
          })
        end
        scrap_results[recipe].expensive.results = insert
      else
        if debug then log(tostring(recipe) .. ".expensive -> not found") end
        scrap_results[recipe] = nil
      end
    end

    if value.normal then
      local insert = {}
      add_to_results(scrap_results, recipe, value.normal.ingredients, "normal")
      if scrap_results[recipe] and scrap_results[recipe].normal then
        for name, amount in pairs(scrap_results[recipe].normal.results) do
          table.insert(insert, {
            name = name,
            amount_min = 1,
            amount_max = amount,
            probability = 0.24
          })
        end
        scrap_results[recipe].normal.results = insert
      else
        if debug then log(tostring(recipe) .. ".normal -> not found") end
        scrap_results[recipe] = nil
      end
    end

    if value.ingredients then
      local insert = {}
      add_to_results(scrap_results, recipe, value.ingredients, "results")
      if scrap_results[recipe] and scrap_results[recipe].results then
        for name, amount in pairs(scrap_results[recipe].results) do
          table.insert(insert, {
            name = name,
            amount_min = 1,
            amount_max = amount,
            probability = 0.24
          })
        end
        scrap_results[recipe].results = insert
      else
        if debug then log(tostring(recipe) .. ".results -> not found") end
        scrap_results[recipe] = nil
      end
    end

  end
  return scrap_results
end
-- log(serpent.block(data.raw.recipe["iron-gear-wheel"], {comment = false}))
-- log(serpent.block(MoltenIron.get_scrap_results()["iron-gear-wheel"], {comment = false}))
-- log(serpent.block(MoltenIron.get_scrap_results()["gun-turret"], {comment = false}))
-- assert(1==2, " D I E")

--- Create the scrap item from ``_types`` and return the table.
---@return table items
function MoltenIron.get_scrap_item()
  local scrap_item = {}
  for _, item in ipairs(_types) do
    if type(item) == "string" then
      table.insert(scrap_item, {
        type = "item",
        name = item .. "-scrap",
        icon = "__Ingredient_Scrap__/graphics/icons/" .. item ..
            "-MoltenIron.png", -- or "__Ingredient_Scrap__/graphics/icons/missing-icon.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "raw-material",
        order = "z-b",
        stack_size = 100
      })
    else
      log(debug.traceback())
      log("String expected, got " .. type(item))
      return nil
    end
  end
  return scrap_item
end
-- log(serpent.block(MoltenIron.get_scrap_item(), {comment = false}))
-- assert(1==2, " D I E")

--- Adds a scrap recipe to an existing Technology if available
---@param item string the item to look for in ``effects.recipe``
---@param name string the name of the recipe to add
---@return table technologies returns matching technologies as array
function MoltenIron.insert_technology(item, name)
  local unlock = {recipe = name, type = "unlock-recipe"}
  local techs = {}
  for key, value in pairs(data.raw.technology) do
    if value.effects then
      for _, effects in pairs(value.effects) do
        if effects.recipe and effects.recipe == item then
          techs[#techs + 1] = key
        end
      end
    end
  end
  for _, v in ipairs(techs) do
    table.insert(data.raw.technology[v].effects, unlock)
  end
  return techs
end
-- log(serpent.block(MoltenIron.insert_technology("steel-plate", "recycle-steel-scrap"), {comment = false}))
-- log(serpent.block(data.raw.technology["steel-processing"], {comment = false}))
-- assert(1==2, " D I E")

--- Create the scrap items recycling recipe from ``_types`` and return the table.
---@param result table ``_types.. "-" ..result`` eg: iron-plate
---@param enabled? boolean default depends on available technologies
---@return table recipes
function MoltenIron.get_scrap_recipes(result, enabled)
  local scrap_recipes = {}
  result = result or _results
  local _result
  enabled = enabled or false
  for _, item in ipairs(_types) do
    if type(item) == "string" then
      local name = "recycle-" .. item .. "-scrap"

      for _, v in ipairs(result) do
        _result = item .. "-" .. v
        if data.raw.item[_result] then
          break
        else
          -- error("item " ..serpent.block(result).. "not found!")
          if debug then
            log("item " .. serpent.block(_result) .. "not found!")
          end
        end
      end

      local order = data.raw.item[_result].order .. "-a" or "z"

      if not data.raw.item[_result] then
        error("Item '" .. item .. "' not found!")
      end -- this is bad
      --[[ CONCEPT in addition there must also an normal/expensive result enabled=... | to much work
      -- if data.raw.recipe[_result] then
      --   if data.raw.recipe[_result].enabled then -- enabled is optional (true) so the lookup can return nil
      --     enabled = data.raw.recipe[_result].enabled
      --   else
      --     if data.raw.recipe[_result].expensive then
      --       enabled = data.raw.recipe[_result].expensive.enabled or true
      --     end
      --     if data.raw.recipe[_result].normal then
      --       enabled = data.raw.recipe[_result].normal.enabled or true
      --     end
      --   end
      -- end ]]
      if not enabled then
        local tech = MoltenIron.insert_technology(_result, name)
        if #tech == 0 then enabled = true end
        -- log("MoltenIron.insert_technology() " ..name.. ": " ..serpent.dump(tech))
        -- log(_result.. " : " ..tostring(enabled))
      end

      table.insert(scrap_recipes, {
        type = "recipe",
        name = name,
        localised_name = {"recipe-name." .. name},
        icons = {
          {
            icon = "__Ingredient_Scrap__/graphics/icons/" .. item ..
                "-MoltenIron.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.5,
            shift = util.by_pixel(0, 0),
            tint = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
          }, {
            icon = "__Ingredient_Scrap__/graphics/icons/recycle.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.5,
            shift = util.by_pixel(0, 0),
            tint = {r = 0.8, g = 1.0, b = 0.8, a = 1.0}
          }
        },
        subgroup = "raw-material",
        category = "smelting",
        order = order,
        enabled = enabled,
        energy_required = 3.2,
        always_show_products = true,
        allow_as_intermediate = false,
        ingredients = {{item .. "-scrap", 10}},
        results = {{_result, 1}}
      })
      enabled = false
    else
      log(debug.traceback())
      log("String expected, got " .. type(item))
      return nil
    end
  end
  return scrap_recipes
end
-- data:extend(MoltenIron.get_scrap_item())
-- MoltenIron.get_scrap_recipes()
-- -- log(serpent.block(MoltenIron.get_scrap_recipes(), {comment = false}))
-- assert(1==2, " D I E")

--- Create and add scrap items *(preferably in data stage)*
---@param scrap_results table Expected format see ``get_scrap_results()``
---@param items table Expected format see ``get_scrap_item()``
---@param recipes table Expected format see ``get_scrap_recipes()``
function MoltenIron.add_scrap(scrap_results, items, recipes)
  -- TODO data.raw.recipe[item].results - big nono

  -- log(serpent.block(scrap_results))

  for item, result in pairs(scrap_results) do

    if result and result.results then -- No diffculty
      -- if data.raw.recipe[item].results then -- this might never happen except it was set by a mod
      --   table.insert(data.raw.recipe[item].results, results.result)
      -- end
      if data.raw.recipe[item].result then
        local data_result = data.raw.recipe[item].result
        local data_amount = data.raw.recipe[item].result_count or 1
        table.insert(result.results, {data_result, data_amount})
        data.raw.recipe[item].results = result.results
        data.raw.recipe[item].main_product = item
        -- log(serpent.block(data.raw.recipe[item]))
      end
    end

    if result.expensive then -- expensive difficulty
      -- if data.raw.recipe[item].expensive.results then -- this might never happen except it was set by a mod
      --   table.insert(data.raw.recipe[item].expensive.results, results.result)
      -- end
      if data.raw.recipe[item].expensive.result then
        local data_result = data.raw.recipe[item].expensive.result
        local data_amount = data.raw.recipe[item].expensive.result_count or 1

        -- if scrap_results[item].expensive.results then
        table.insert(result.expensive.results, {data_result, data_amount})
        data.raw.recipe[item].expensive.results = result.expensive.results
        data.raw.recipe[item].expensive.main_product = item
        --         else
        -- log(serpent.block(tostring(scrap_results[item])..".expensive.results not found!"))
        --         end
      end
      -- log(serpent.block(data.raw.recipe[item]))
    end

    if result.normal then -- normal diffculty
      -- if data.raw.recipe[item].normal.results then -- this might never happen except it was set by a mod
      --   table.insert(data.raw.recipe[item].normal.results, results.result)
      -- end
      if data.raw.recipe[item].normal.result then
        local data_result = data.raw.recipe[item].normal.result
        local data_amount = data.raw.recipe[item].normal.result_count or 1

        -- if scrap_results[item].normal.results then
        table.insert(scrap_results[item].normal.results,
                     {data_result, data_amount})
        data.raw.recipe[item].normal.results = result.normal.results
        data.raw.recipe[item].normal.main_product = item
        --         else
        -- log(serpent.block(data.raw.recipe[item].name..".normal.results not found!"))
        --         end
      end
    end
  end
  data:extend(items)
  data:extend(recipes)
end

MoltenIron.add_scrap(MoltenIron.get_scrap_results(),
                     MoltenIron.get_scrap_item(), MoltenIron.get_scrap_recipes())

-- log(serpent.block(data.raw.technology["steel-processing"], {comment = false}))
-- assert(1==2, " D I E")
