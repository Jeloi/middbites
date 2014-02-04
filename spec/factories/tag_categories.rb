# == Schema Information
#
# Table name: tag_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag_category do
  	name "Miscellaneous"
  	factory :tastes do
	    name "Tastes"
	    after(:build) do |tag_category|
	    	["Tangy", "Sweet", "Salty"].each do |tag|
	      	tag_category.tags << Tag.new(name: tag)
	    	end
	    end
  	end
  end
end
