# == Schema Information
#
# Table name: items
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  item_category_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory Item do
  	# name "A Test Item"	
    sequence(:name) {|n| "Item "+n.to_s}

  	factory :peanut_butter do
  		name "Peanut Butter"	
  	end
  	factory :jelly do
  		name "Jelly"	
  	end
  	factory :bread do
  		name "Bread"	
  	end

	end

end
