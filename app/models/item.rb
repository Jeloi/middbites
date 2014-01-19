# == Schema Information
#
# Table name: items
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  item_category_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Item < ActiveRecord::Base
	# Associations
	has_many :items
	has_many :recipes, through: :ingredients
	belongs_to :item_category
	before_save :set_item_category

	validates_uniqueness_of :name, message: "must be unique!"

	# Sunspot Solr Search
	searchable do
	  text :name
	end	

	# Sets the this item's item_category to "Other" if one is not specified
	def set_item_category
		if self.item_category.nil?
			self.item_category = ItemCategory.find_or_create_by(name: "Other")
		end
	end
end
