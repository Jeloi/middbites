# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory Tag do

  	factory :yummy do
  		name "Yummy"
      association :tag_category
  	end

  	factory :breakfast do
  		name "Breakfast"
      association :tag_category
  	end

  	factory :sweet do
  		name "Chewy"
      association :tag_category
  	end

  end
end
