require 'spec_helper'


feature "Creating a Recipe," do
	before(:each) do
	  visit new_recipe_path
	end

	scenario "without filling in proper fields" do
	  click_button("create_recipe")
	  expect(page).to have_content "can't be blank"
	end

	scenario "adding recipes" do
		fill_in_text_fields
		click_button("create_recipe")
		expect(page).to have_content "successfully"
	end

	def fill_in_text_fields
		within(:css, "div.format-recipe-box") do
			fill_in "recipe_title", with: "A Good Recipe"
			fill_in "recipe_blurb", with: "A very tasty recipe you should try!"
			fill_in "recipe_directions", with: "Get pasta. Add sauce. Add Garlic. Mix."
		end
	end

end