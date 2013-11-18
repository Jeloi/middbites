# == Schema Information
#
# Table name: tags
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  tag_category_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :recipes, :through => :taggings
	belongs_to :tag_category
end
