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
  extend FriendlyId
  # Friendly_id gem use database slug
  friendly_id :title, :use => :slugged

	# Associations
	belongs_to :user
	has_many :ingredients
	has_many :items, through: :ingredients
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:item_id].blank? }, :allow_destroy => true


	# Validations
  TITLE_LENGTH = 40
  BLURB_LENGTH = 100
	validates_uniqueness_of :title, on: :create, message: "That name is already taken!", case_sensitive: false
	validates_presence_of :title, :blurb, :directions, on: :create, message: "can't be blank"

  # Friendly_Id generate new slug
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def display_title
    title.downcase.titlecase
  end

end
