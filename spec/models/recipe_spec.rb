# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  directions :text
#  title      :string(255)
#  blurb      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
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


  # Instance Methods
  describe "Instance Methods" do
    describe "friendly_id and to_param working" do
      before(:each) do
        @recipe = create(:recipe, :with_ingredients)
      end
      it { expect(@recipe.to_param).to eql("the-classic")}
      it { expect(Recipe.find("1-the-classic")).to eql(@recipe) }
      it { expect(Recipe.friendly.find("the-classic")).to eql(@recipe) }
    end    
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
end
