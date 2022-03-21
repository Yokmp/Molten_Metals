
-- Vanilla
make_new_casting_recipe("copper-ore", "copper-plate", {20,20}, {1,1}, {1.6,1.6})
make_new_casting_recipe("copper-ore", "copper-cable", {20,20}, {2,2}, {0.5,0.5})
make_new_casting_recipe("iron-ore", "iron-plate", {20,20}, {1,1}, {1.6,1.6})
make_new_casting_recipe("iron-ore", "steel-plate", {100,100}, {1,1}, {8,16})
make_new_casting_recipe("iron-ore", "iron-gear-wheel", {80,80}, {2,2}, {1,1})
make_new_casting_recipe("iron-ore", "iron-stick", {20,20}, {2,2}, {0.5,0.5})
make_new_casting_recipe("iron-ore", "rail", {120,120}, {2,2}, {0.5,0.5})
-- table.insert(data.raw.recipe["molten-rail"].ingredients, {type = "item", name = "stone", amount = 1})
make_new_casting_recipe("stone", "stone-brick", {20,20}, {1,1}, {1.6,1.6})
make_new_casting_recipe("uranium-ore", "uranium-238", {200,200}, {1,1}, {12,12})
make_new_casting_recipe("uranium-ore", "uranium-235", {200,200}, {1,1}, {12,12})
data.raw.recipe["molten-uranium-238"].results = {
  {type = "item", name = "uranium-238", amount = 1, probability = 0.993},
  {type = "item", name = "uranium-235", amount = 1, probability = 0.007},
  {type = "fluid", name = "steam", amount = 200, temperature = 165}
}
