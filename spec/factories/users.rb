FactoryGirl.define	do
	
  factory :user do
    name "Jason Bourne" 
    first_name "Jason"
    last_name "Bourne"
    provider "facebook"

    trait :with_recipe do
    	after(:build) do |user|
    		user.recipes << FactoryGirl.build(:recipe, :with_ingredients)
    	end
    end
  end
end