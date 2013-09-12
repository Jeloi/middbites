# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  directions         :text
#  title              :string(255)
#  blurb              :string(255)
#  user_id            :integer
#  recipe_category_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Recipe do
  
  # Validations
  it "has a valid factory" do
    expect(FactoryGirl.build(:recipe_with_ingredients)).to be_valid #without Factory Girl syntax shortening
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
		create(:recipe_with_ingredients)
		expect(build :recipe).to have(1).errors_on(:title)
	end

  it "performs title uniqueness validation, case insensitive" do
    create(:recipe_with_ingredients)
    expect(build :recipe, title: "the classic").to have(1).errors_on(:title)
  end

	# Associations
	it {expect(subject).to have_many(:items).through(:ingredients)}
	it {should have_many(:items).through(:ingredients)}
	it {should belong_to(:user)}
  it { should have_many(:votes) }
  it { should have_many(:bites) }
	it { should have_many(:favorites) }


  # Instance Methods
  describe "Instance Methods" do
    describe "friendly_id and to_param working" do
      before(:each) do
        @recipe = create(:recipe_with_ingredients)
      end
      it { expect(@recipe.to_param).to eql("the-classic")}
      it { expect(Recipe.find("1-the-classic")).to eql(@recipe) }
      it { expect(Recipe.friendly.find("the-classic")).to eql(@recipe) }
    end    
  end
end
