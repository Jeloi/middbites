require "spec_helper"

feature "Show Recipe Page" do
  context "user signed in" do
    let(:user) { User.find_by_name("Jeremy Ho") } 
  	before(:each) do
	    login_with_oauth
      @user = FactoryGirl.create(:user)
	    @recipe = FactoryGirl.create(:recipe, :with_ingredients, :user => @user)
	    visit recipe_path(@recipe)
    end

    it "should do something" do
      expect(User.first).not_to be_nil
    end

    it "should show correct content" do
      expect(page).to have_content "The Classic"
      expect(page).to have_content "Jelly"
      recipe = FactoryGirl.create(:recipe, :with_ingredients, title: "Stirry Fry", user: @user)
      visit recipe_path(recipe)
      expect(page).to have_content "Stirry Fry"
      expect(page).to have_content "Jason Bourne"
    end


    describe "Voting", js: true do
      let(:click_votes) do
        click_link('1_bites_link') 
        click_link('1_favorites_link')
        @recipe.reload
      end
      it "should create proper relations on vote" do
        click_votes
        expect(user.votes.count).to eq(2)
        expect(user.bites.count).to eq(1)
        expect(user.favorites.count).to eq(1)
        expect(user.favorite_recipes).to include(@recipe)
        expect(user.bit_recipes).to include(@recipe)
      end

      it "should remove relations and delete records on unvote" do
        click_votes
        expect { click_link('1_bites_link')  }.to change {user.bites.count}.from(1).to(0)
        expect { click_link('1_favorites_link')  }.to change {user.favorites.count}.from(1).to(0)
        expect(Vote.count).to eq(0)
      end

      it "should update counter caches on vote and unvote" do
        click_votes
        expect(@recipe.bites_count).to eq(1)
        expect(@recipe.favorites_count).to eq(1)
        click_link('1_bites_link') 
        click_link('1_favorites_link')
        @recipe.reload
        expect(@recipe.bites_count).to eq(0)
        expect(@recipe.favorites_count).to eq(0)
      end
    end

  end

  context "guest user not signed in" do
  	
  end
end