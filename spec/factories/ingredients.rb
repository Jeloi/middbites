FactoryGirl.define do
  factory :ingredient do
  	quantity "1"
  	association :item
  end
end
