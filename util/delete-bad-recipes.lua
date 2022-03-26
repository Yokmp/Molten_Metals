-- 'delete bad recipes'
-- 'Version 002 from 2017-10-26'
-- 'License: Free for all, but not sell. Or give me money, if you sold it.'
-- 'darkfrei'

local recipes = data.raw.recipe

local items = {}


function return_item_prototype (item_name)
	local raw = data.raw
	local item_type_list = { "ammo", "armor", "gun", "item", "capsule", "repair-tool", "mining-tool", "item-with-entity-data", "rail-planner", "tool", "blueprint", "deconstruction-item", "blueprint-book", "selection-tool", "item-with-tags", "item-with-label", "item-with-inventory", "module"}
	for i, item_type in pairs (item_type_list) do
		if raw[item_type][item_name] then
			--log ('data.raw["'.. item_type ..'"]["'..item_name.. '"] was ok')
			return raw[item_type][item_name]
		end
	end
	return false
end

function pro_ingredients_or_results_iterator (ingredients_or_results)
	local must_be_deleted  = false
	for number, tabl in pairs (ingredients_or_results) do
		if (tabl.type == 'item') then
			if not (return_item_prototype (tabl.name)) then
				must_be_deleted  = true
				log ('  /' .. 'Found bad item! - ' .. tabl.name)
			end
		end
	end
	return must_be_deleted
end

function easy_results_iterator (recipe_handler, recipe_name)
	local must_be_deleted = false
	-- data.raw.recipe["stone-brick"].result = "stone-brick"
	if not (return_item_prototype (recipe_handler.result)) then
		must_be_deleted  = true
		log ('  /' .. 'Found bad item! - ' .. recipe_handler.result)
	end
	return must_be_deleted
end

function check_recipe_handler (handler, recipe_name)
	local must_be_deleted  = false
	if handler.ingredients then
		if (pro_ingredients_or_results_iterator (handler.ingredients)) then
			log ('  /' .. 'Bad recipe: '.. recipe_name)
			must_be_deleted  = true
		end
	else
		log ('  /' .. 'Easy recipes ingredients was not checked for '.. recipe_name)
	end

	if handler.results then
		if (pro_ingredients_or_results_iterator (handler.results)) then
			log ('  /' .. 'Bad recipe: '.. recipe_name)
			must_be_deleted  = true
		end
	else
		if (easy_results_iterator (handler, recipe_name)) then
			log ('  /' .. 'Easy recipes results was bad for '.. recipe_name)
			must_be_deleted  = true
		end
	end
	return must_be_deleted
end

for recipe_name, recipe_prototype in pairs (recipes) do
	local must_be_deleted = false
	if recipe_prototype.normal and recipe_prototype.expensive then
		must_be_deleted = check_recipe_handler (recipe_prototype.normal, recipe_name)
			and check_recipe_handler (recipe_prototype.expensive, recipe_name)
		if must_be_deleted then
			log ('  /' .. 'normal or expensive recipe ' .. recipe_name)
		end
	else
		must_be_deleted = check_recipe_handler (recipe_prototype, recipe_name)
		if must_be_deleted then
			log ('  /' .. 'standard recipe ' .. recipe_name)
		end
	end
	if must_be_deleted then
		--delete recipe
		log ('  /' .. 'The recipe was deleted: ' .. recipe_name)
		data.raw.recipe[recipe_name] = nil
	end
end


-- 'delete bad technology unlock-recipe'

 function is_in_list (value, list)
	 for i, v in pairs (list) do
		if value == v then
			return true
		end
	 end
	 return false
 end

local recipe_list = {}
for recipe_name, v in pairs (recipes) do
	recipe_list[#recipe_list+1] = recipe_name
end

local technologies = data.raw.technology
for technology_name, technology in pairs (technologies) do
	if technology.effects then
		local effects = technology.effects
		for i, effect in pairs (effects) do
			if (effect.type == "unlock-recipe") and (effect.recipe) then
				local effect_recipe_name = effect.recipe
				if not (is_in_list (effect_recipe_name, recipe_list)) then
					log ('  /' .. "'Warning!' " .. technology_name .. ' has recipe ' .. effect_recipe_name .. ' and effect must be deleted.')
					data.raw.technology[technology_name].effects[i] = nil
				end
			end
		end
	end
end