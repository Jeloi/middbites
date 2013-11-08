# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  item_id    :integer
#  name       :string(255)      not null
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
  describe "set_name callback," do
  	
    before(:each) do
      @ingredient = create(:ingredient)
      @item = @ingredient.item
    end

    it { expect(@ingredient.name).to eql("A Test Item") }
    it { expect(@ingredient.name).to eql(@ingredient.item.name) }

    it "should change name on item change" do
      @ingredient.item = create(:jelly)
      @ingredient.save
      expect(@ingredient.name).to eql("Jelly")
    end

    it "should change name on item name change" do
      @item.update_attributes(name: "Jam")
      @ingredient.save
      expect(@ingredient.name).to eql("Jam")
    end

  end

end
