# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  item_id    :integer
#  quantity   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Ingredient do
  
  describe "has a valid factory with an item" do
    it {expect(build(:ingredient)).to be_valid}
    it { expect(build(:ingredient).quantity).to eql("1") }
  end
  describe "Instance Methods - " do
  	
  	it "name" do
  	  @ingredient = create(:ingredient)
  	  expect(@ingredient.name).to eql("A Test Item")
  	end
  end
end
