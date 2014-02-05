# == Schema Information
#
# Table name: items
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  item_category_id  :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#  ingredients_count :integer          default(0)
#

FactoryGirl.define do
  factory Item do
  	name "A Test Item"	

    factory :item_sequence do
      sequence(:name) {|n| "Item "+n.to_s}
    end

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
