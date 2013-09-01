FactoryGirl.define do
  factory :recipe do
    title "The Classic"
    blurb "A sandwich so good you'll never forget it"
  	directions "Get two pieces of bread. Spread peanut butter on one, jelly on the other. Stick the two pieces together"

  	factory :recipe_with_ingredients do
		
  		after(:build) do |recipe|
  			[:jelly, :peanut_butter, :bread].each do |item|
  				recipe.ingredients << Ingredient.new(quantity: "2", item: FactoryGirl.build(item))
  			end
  		end

  	end	
  end
end
