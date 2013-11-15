# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag_category do

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
