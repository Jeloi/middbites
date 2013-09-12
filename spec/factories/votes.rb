# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    recipe nil
    user nil
    recipe_owner_id 1
    type ""
  end
end
