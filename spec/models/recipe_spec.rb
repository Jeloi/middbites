# == Schema Information
#
# Table name: recipes
#
#  id                :integer          not null, primary key
#  directions        :text
#  title             :string(255)
#  blurb             :string(255)
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  slug              :string(255)
#  bites_count       :integer          default(0)
#  favorites_count   :integer          default(0)
#  comments_count    :integer          default(0)
#  image             :string(255)
#  score             :decimal(18, 6)   default(0.0)
#  ingredients_list  :string(255)
#  ingredients_count :integer          default(0)
#  tags_list         :string(255)
#

require 'spec_helper'

describe Recipe do
  
  # Validations
  it "has a valid factory" do
    expect(FactoryGirl.build(:recipe, :with_ingredients)).to be_valid #without Factory Girl syntax shortening
  end

  it "is invalid without a title" do
		expect(build(:recipe, title: nil)).to \
			have(1).errors_on(:title)
  end

  it "is invalid without a description" do
    expect(build(:recipe, directions: nil)).to have(1).errors_on(:directions)
  end
  it "is invalid without a blurb" do
    expect(build(:recipe, blurb: nil)).to have(1).errors_on(:blurb)
  end

	it "is invalid if the title is not unique" do
		create(:recipe, :with_ingredients)
		expect(build :recipe).to have(1).errors_on(:title)
	end

  it "performs title uniqueness validation, case insensitive" do
    create(:recipe, :with_ingredients)
    expect(build :recipe, title: "the classic").to have(1).errors_on(:title)
  end

	# Associations
	it {expect(subject).to have_many(:items).through(:ingredients)}
	it {should have_many(:items).through(:ingredients)}
	it {should belong_to(:user)}
  it { should have_many(:votes) }
  it { should have_many(:bites) }
  it { should have_many(:favorites) }
  it { should have_many(:taggings) }
	it { should have_many(:tags).through(:taggings) }
  it { should have_many(:comments) }

  # Callbacks
  describe "Recipe Callback: " do
    describe "set_ingredient_list" do
      it "properly creates ingredient_list with 3 ingredients" do
        recipe = create(:recipe, :with_ingredients)
        expect(recipe.ingredients.count).to eql(3)
        expect(recipe.ingredients_list).to eql("Jelly, Peanut Butter, Bread")
      end
      it "properly creates ingredients_list with 7 ingredients" do
        recipe = create(:recipe, :with_multiple_ingredients, ingredient_count: 7)
        expect(recipe.ingredients.count).to eql(7)
        expect(Item.count).to eql(7)
        expect(recipe.ingredients_list).to eql("Item 1, Item 2, Item 3, Item 4, Item 5, Item 6, Item 7")
      end
    end

    describe "set_tag_list" do
      it "properly creates tags_list" do
        recipe = create(:recipe, :with_ingredients, :with_taggings)
        expect(recipe.tags.count).to eql 3
        expect(recipe.taggings.count).to eql 3
        expect(recipe.tags_list).to eql "Yummy, Breakfast, Chewy"
      end
    end
  end


  # Instance Methods
  describe "friendly_id and to_param working" do
    before(:each) do
      @recipe = create(:recipe, :with_ingredients)
    end
    it { expect(@recipe.to_param).to eql("the-classic")}
    it { expect(Recipe.find("1-the-classic")).to eql(@recipe) }
    it { expect(Recipe.friendly.find("the-classic")).to eql(@recipe) }
  end    

  describe "Commenting cache column" do
    let(:user) { create(:user) } 
    let(:recipe) { create(:recipe, :with_ingredients, :owned) } 
    it "should update upon comment creation" do
      recipe.comments.create(comment: "This is a test comment", user_id: user.id)
      recipe.reload
      expect(recipe.comments.count).to eql  1
      expect(recipe.comments_count).to eql 1
    end

    it "should update upon destroying comment" do
      recipe.comments.create(comment: "This is a test comment", user_id: user.id)
      comment_id = recipe.comments.first.id
      user.comments.where(commentable_id: recipe.id).destroy(comment_id)
      expect(recipe.comments.count).to eql  0
      expect(recipe.comments_count).to eql 0
    end
  end

  describe "should destroy dependent associations (ingredients, bites, favorites, tags)" do
    let(:user) { create(:user) } 
    before(:each) do
      @recipe = create(:recipe, :with_ingredients, :owned, :with_taggings)
      user.vote(@recipe, "bites")
      user.vote(@recipe, "favorites") 
    end
    it "should destroy dependent associations" do
     expect(Ingredient.all.count).to eql 3
     expect(Tagging.all.count).to eql 3
     expect(Vote.all.count).to eql 2
     @recipe.destroy
     expect(Ingredient.all.count).to eql 0
     expect(Tagging.all.count).to eql 0
     expect(Vote.all.count).to eql 0
    end
  end

  describe "Calculate score methods" do
    let(:user) { create(:user) }
    let(:recipe) { create(:recipe, :with_ingredients, :owned, :with_taggings) } 
    let(:vote_on_recipe) do
      user.vote(recipe, "bites")
      user.vote(recipe, "favorites")
      recipe.reload
    end
    let(:unvote_on_recipe) do
      user.unvote(recipe, "bites")
      user.unvote(recipe, "favorites")
      recipe.reload
    end
    it "vote update scores, then unvote update scores" do
      expect(recipe.score).to eql 0.0
      recipe.vote_update_score "Bite"
      recipe.vote_update_score "Favorite"
      recipe.reload
      expect(recipe.score).to eql Recipe::BITE_WEIGHT * 1.0 + Recipe::FAV_WEIGHT * 1.0
      recipe.unvote_update_score "Favorite"
      expect(recipe.score).to eql Recipe::BITE_WEIGHT * 1.0
      recipe.unvote_update_score "Bite"
      expect(recipe.score).to eql 0
    end

    it "voting on recipe should update recipe score" do
      expect { 
        vote_on_recipe
       }.to change { recipe.score }.by Recipe::BITE_WEIGHT * 1.0 + Recipe::FAV_WEIGHT * 1.0
    end

    it "unvoting on recipe should udpate recipe score" do
      vote_on_recipe
      expect { 
        unvote_on_recipe
       }.to change { recipe.score }.by -(Recipe::BITE_WEIGHT * 1.0 + Recipe::FAV_WEIGHT * 1.0)
    end

    it "calculate_score should not change existing score" do
      expect(recipe.score).to eql 0.0
      vote_on_recipe
      expect{ recipe.calculate_score }.not_to change {recipe.score}
    end
  end
end
