# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  item_id    :integer
#  name       :string(255)      not null
#  quantity   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ingredient < ActiveRecord::Base
	# Associations
	belongs_to :recipe, counter_cache: true
	belongs_to :item, counter_cache: true

	QUANTITY_LENGTH = 30

	# Callbacks
	before_save :set_name

private
	
	# Set the ingredient name with it's associated item's name
	def set_name
		self.name = item.name
	end
end
