FactoryGirl.define	do
	
  factory User do
    name "Jason Bourne" 
    first_name "Jason"
    last_name "Bourne"
    provider "facebook"

    factory :user_with_recipe do
    	after(:build) do |user|
    		user.recipes << FactoryGirl.build(:recipe_with_ingredients)
    	end
    end
  end
end