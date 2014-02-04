# == Schema Information
#
# Table name: tags
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  tag_category_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#  taggings_count  :integer          default(0)
#

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
