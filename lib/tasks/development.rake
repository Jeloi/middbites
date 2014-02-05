desc "Update counter_cache column for items and recipes (ingredients_count)"
task :update_ingredients_count => [:environment] do
	Item.reset_column_information
	Item.all.each do |item|
		# Item.update_counters item.id, :ingredients_count => item.ingredients.length
		Item.reset_counters item.id, :ingredients
	end

	Recipe.all.each do |recipe|
		# Recipe.update_counters recipe.id, :ingredients_count => recipe.ingredients.length
		Recipe.reset_counters recipe.id, :ingredients
	end
end


desc "Save all recipes to call callbacks, such as set_tags_list/set_ingredients_list"
task :resave_recipes => [:environment] do
	Recipe.all.each do |recipe|
		recipe.save
	end
end