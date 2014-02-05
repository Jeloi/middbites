# == Schema Information
#
# Table name: recipes
#
#  id                :integer          not null, primary key
#  directions        :text
#  title             :string(255)
#  blurb             :string(255)
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  slug              :string(255)
#  bites_count       :integer          default(0)
#  favorites_count   :integer          default(0)
#  comments_count    :integer          default(0)
#  image             :string(255)
#  score             :decimal(18, 6)   default(0.0)
#  ingredients_list  :string(255)
#  ingredients_count :integer          default(0)
#  tags_list         :string(255)
#

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

    trait :with_multiple_ingredients do
      ignore do
        ingredient_count 3
      end
      after(:build) do |recipe, evaluator|
        item_list = build_list(:item_sequence, evaluator.ingredient_count)
        item_list.each do |item|
          recipe.ingredients << Ingredient.new(item: item)
        end
      end
    end

    trait :with_taggings do
      after(:build) do |recipe|
        [:yummy, :breakfast, :chewy].each do |tag|
          recipe.taggings << Tagging.new(tag: FactoryGirl.build(tag))
        end
      end
    end
  end
end
