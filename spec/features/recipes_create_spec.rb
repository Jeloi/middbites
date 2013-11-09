require 'spec_helper'


feature "Creating a Recipe" do
	before(:each) do
		create_item_factories
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


	context "| filling in the fields and selecting an ingredient", js: true do
		before(:each) do
			fill_in_text_fields
			select_from_chosen('Jelly', from: 'ingredient_selector')
			# select('Peanut Butter', from: 'ingredient_selector')
			# select('Bread', from: 'ingredient_selector')
			click_button("create_recipe")
		end
		
		# # Multiple expects in one example, bad practice but only workaround to the overhead in before(:each)
		it "| should successfully create a recipe and be at the right path" do
			@new_recipe = Recipe.first
			expect(page).to have_content "successfully" 
			expect(current_path).to eql '/recipes/a-good-recipe' 
			expect(Recipe.count).to eql(1) 
			expect(@new_recipe.title).to eql "A Good Recipe"  
			expect(@new_recipe.ingredients.count).to eql 3
			expect(@new_recipe.ingredients.pluck(:name)).to include("Jelly", "Peanut Butter", "Bread") 
		end

	end

	def create_item_factories
		[:jelly, :peanut_butter, :bread].each do |item|
			FactoryGirl.create(item)
		end
	end

	def select_from_chosen(item_text, options)
	  field = find_field(options[:from], visible: false)
	  option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
	  page.execute_script("$('##{field[:id]}').val('#{option_value}')")
	end


	def fill_in_text_fields
		within(:css, "div.recipe-form") do
			fill_in "recipe_title", with: "A Good Recipe"
			fill_in "recipe_blurb", with: "A very tasty recipe you should try!"
			fill_in "recipe_directions", with: "Get pasta. Add sauce. Add Garlic. Mix."
		end
	end



end