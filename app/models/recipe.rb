# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  directions         :text
#  title              :string(255)
#  blurb              :string(255)
#  user_id            :integer
#  recipe_category_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Recipe < ActiveRecord::Base
	# Associations
	belongs_to :user
	has_many :ingredients
	has_many :items, through: :ingredients

	# Validations
	validates_uniqueness_of :title, on: :create, message: "That name is already taken!"
	validates_presence_of :title, :blurb, :directions, on: :create, message: "can't be blank"
end
