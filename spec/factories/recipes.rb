FactoryGirl.define do
  factory :recipe do

    title "The Classic"

    blurb "A sandwich so good you'll never forget it"
    directions "Get two pieces of bread. Spread peanut butter on one, jelly on the other. Stick the two pieces together"

    # factory :multiple_recipes do
    #   sequence(:title) do |n|
    #     ["A Delcious Holiday Soup", "Morning Egger", "Rock Climber's Panini"].sample + n.to_s
    #   end
    #   user_id User.first.id
    #   image Recipe.first.image
    # end

    trait :owned do
     after(:build) do |recipe|
      recipe.user = FactoryGirl.build(:user)
     end
    end

  	trait :with_ingredients do
  		after(:build) do |recipe|
  			[:jelly, :peanut_butter, :bread].each do |item|
  				recipe.ingredients << Ingredient.new(quantity: "2", item: FactoryGirl.build(item))
  			end
  		end
  	end	

    trait :with_taggings do
      after(:build) do |recipe|
        [:yummy, :breakfast, :sweet].each do |tag|
          recipe.taggings << Tagging.new(tag: FactoryGirl.build(tag))
        end
      end
    end
  end
end
