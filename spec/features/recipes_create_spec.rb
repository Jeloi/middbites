require 'spec_helper'


feature "Creating a Recipe" do
	before(:each) do
		create_item_factories
		FactoryGirl.create(:tastes)
		login_with_oauth
		visit new_recipe_path
	end

	it { expect(Item.count).to eql 3 }

	describe "| without filling in proper fields or selecting an Ingredient" do
		before(:each) do
			click_button("create_recipe")
		end

		it {expect(page).to have_content "can't be blank"}
		it {
			#save_and_open_page
			expect(page).to have_content "at least one ingredient"
		}
	end


	context "| filling in the fields and selecting ingredients", js: true do
		before(:each) do
			fill_in_text_fields
			select_and_trigger_change('Jelly', from: 'ingredient_selector')
			select_and_trigger_change('Peanut Butter', from: 'ingredient_selector')
			select_and_trigger_change('Bread', from: 'ingredient_selector')
		end
		
		# # Multiple expects in one example, bad practice but only workaround to the overhead in before(:each)
		it "| should successfully create a recipe and be at the right path" do
			click_button("create_recipe")
			new_recipe = Recipe.first
			expect(page).to have_content "successfully" 
			expect(current_path).to eql '/recipes/a-good-recipe' 
			expect(Recipe.count).to eql(1) 
			expect(new_recipe.title).to eql "A Good Recipe"  
			expect(new_recipe.ingredients.count).to eql 3
			expect(new_recipe.ingredients.pluck(:name)).to include("Jelly", "Peanut Butter", "Bread") 
		end

		it "should not be able to add same ingredient twice" do
		  	select_and_trigger_change('Jelly', from: 'ingredient_selector')
		  	click_button("create_recipe")
		  	expect(Recipe.first.ingredients.count).to eql 3
		end

		it "should be able to dynamically remove and add ingredients" do
		  page.execute_script("$('#remove-all').click()") # 0 ingredients
		  select_and_trigger_change('Jelly', from: 'ingredient_selector')
		  select_and_trigger_change('Bread', from: 'ingredient_selector')
		  page.execute_script("$('.remove.custom-action:visible').first().click()") # 0 ingredients
		  select_and_trigger_change('Peanut Butter', from: 'ingredient_selector')
		  click_button("create_recipe")
		  pp Recipe.first.ingredients
			expect(Recipe.first.ingredients.count).to eql 2
			expect(Recipe.first.ingredients.pluck(:name)).to include("Jelly", "Peanut Butter")
		end

		describe "tagging functionality" do
			it "selecting tags with chosen should work" do
			  tag_chosen_select('Salty', from: 'tag_selector')
			  tag_chosen_select('Tangy', from: 'tag_selector')
			  click_button("create_recipe")
			  expect(Recipe.first.tags.count).to eql 2
			  expect(Recipe.first.taggings.count).to eql 2
			end

			it "dynamically removing and deleting should work" do
			  tag_chosen_select('Salty', from: 'tag_selector')
			  tag_chosen_select('Tangy', from: 'tag_selector')
			  tag_chosen_select('Sweet', from: 'tag_selector')
			  page.execute_script("$('.tags .chosen-choices .search-choice-close').first().click()")
			  page.execute_script("$('.tags .chosen-choices .search-choice-close').first().click()")
			  tag_chosen_select('Tangy', from: 'tag_selector')
			  click_button("create_recipe")
			  expect(Recipe.first.tags.count).to eql 2
			  expect(Recipe.first.taggings.count).to eql 2
			end

		end
	end





	def create_item_factories
		[:jelly, :peanut_butter, :bread].each do |item|
			FactoryGirl.create(item)
		end
	end


	def fill_in_text_fields
		within(:css, "div.recipe-form") do
			fill_in "recipe_title", with: "A Good Recipe"
			fill_in "recipe_blurb", with: "A very tasty recipe you should try!"
			fill_in "recipe_directions", with: "Get pasta. Add sauce. Add Garlic. Mix."
		end
	end



end