require 'spec_helper'

feature "Voting" do

	describe "on show Recipe page" do
	  before(:each) do
	    # request = ActionController::TestRequest.new()
	    # request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:provider]
	    login_with_oauth
      @recipe = FactoryGirl.create(:recipe, :with_ingredients, :user => User.first)
      visit recipe_path(@recipe)
    end

    let(:user) { User.first }
    let(:my_recipe) { FactoryGirl.create(:recipe, :with_ingredients, :user => User.first) }

    it "should show correct content" do
      expect(page).to have_content "The Classic"
      recipe = FactoryGirl.create(:recipe, :with_ingredients, title: "Stirry Fry")
      visit recipe_path(recipe)
      expect(page).to have_content "Stirry Fry"
    end

    

	end

	shared_examples "a Vote subclass" do |vote, a_param|


		it "description" do
			# visit recipe_path
		end

	end

	describe Bite do
		it_should_behave_like "a Vote subclass", Bite, 3
	end

	describe Favorite do
		it_should_behave_like "a Vote subclass", Favorite, 2
	end
end
