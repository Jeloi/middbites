# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  provider          :string(255)
#  uid               :string(255)
#  name              :string(255)
#  oauth_token       :string(255)
#  oauth_expires_at  :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  confirmation_code :string(255)
#  confirmed         :boolean          default(FALSE)
#  email             :string(255)
#  first_name        :string(255)
#  last_name         :string(255)
#  image             :string(255)
#  handle            :string(255)
#

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
