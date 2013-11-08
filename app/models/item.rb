# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Item < ActiveRecord::Base
	# Associations
	has_many :items
	has_many :recipes, through: :ingredients
	belongs_to :item_category
end
