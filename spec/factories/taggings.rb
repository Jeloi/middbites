# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tagging do
    tag nil
    recipe_belongs_to "MyString"
  end
end
