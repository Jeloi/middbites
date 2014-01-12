# == Schema Information
#
# Table name: recipes
#
#  id              :integer          not null, primary key
#  directions      :text
#  title           :string(255)
#  blurb           :string(255)
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  slug            :string(255)
#  bites_count     :integer          default(0)
#  favorites_count :integer          default(0)
#  comments_count  :integer          default(0)
#  image           :string(255)
#  score           :float
#  temperature     :float
#

class Recipe < ActiveRecord::Base
  acts_as_commentable
  extend FriendlyId
  # Friendly_id gem use database slug
  friendly_id :title, :use => :slugged
  mount_uploader :image, ImageUploader


  # Constants
  BITE_WEIGHT = 1.0
  FAV_WEIGHT = 1.8
  TITLE_LENGTH = 40
  BLURB_LENGTH = 100

	# Associations
	belongs_to :user
	has_many :ingredients, dependent: :destroy
	has_many :items, through: :ingredients
  has_many :votes
  has_many :bites, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:item_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :taggings, :reject_if => lambda { |a| a[:tag_id].blank? }, :allow_destroy => true


	# Validations

	validates_uniqueness_of :title, message: "That name is already taken!", case_sensitive: false
	validates_presence_of :title, :blurb, :directions, message: "can't be blank"
  validate :validate_ingredients_count

  def validate_ingredients_count
    errors.add(:ingredient, "too many!") if ingredients.size > 10
    errors.add(:ingredient, "recipe needs at least one ingredient") if ingredients.size == 0
  end

  # -- Score instance methods -- 
  def calculate_score
    self.score = BITE_WEIGHT * bites_count + FAV_WEIGHT * favorites_count
    self.save!
  end

  # Update score on a vote, multipling my vote class's corresponding weight
  def vote_update_score vote_type
    if vote_type == "Bite"
      self.score += 1.0 * BITE_WEIGHT
    elsif vote_type == "Favorite"
      self.score += 1.0 * FAV_WEIGHT
    end
    self.save
  end

  # Update score on an unvote
  def unvote_update_score vote_type
    if vote_type == "Bite"
      self.score -= 1.0 * BITE_WEIGHT
    elsif vote_type == "Favorite"
      self.score -= 1.0 * FAV_WEIGHT
    end
    self.save
  end

  # -- Hotness instance methods -- 
  def calculate_hotness
    
  end

  # Friendly_Id generate new slug
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  # --- Class Methods --- #

  # Custom sql query to return recipes that have bites in the last week
  # Optional parameters for pagination and ordering
  def self.popular_this_week(page=nil, per_page=nil, order='DESC')
    time = Time.now.weeks_ago(1).to_s(:db) # database friendly time
    sql = "SELECT * FROM 
      (SELECT recipes.*, 
        (SELECT count(votes.id) FROM votes WHERE votes.type='Bite' and votes.recipe_id=recipes.id and votes.created_at > '#{time}') AS recent_bites
      FROM recipes ORDER BY recipes.created_at) AS data
      WHERE recent_bites > 0 ORDER BY recent_bites #{order}"
    if !page.nil? && !per_page.nil?
      self.paginate_by_sql(sql, page: page, per_page: per_page)
    else
      self.find_by_sql(sql)
    end
  end

  # Custom sql query to return recipes that have bites in the last month
  # Optional parameters for pagination and ordering
  def self.popular_this_month(page=nil, per_page=nil, order='DESC')
    time = Time.now.months_ago(1).to_s(:db)
    sql = "SELECT * FROM 
      (SELECT recipes.*, 
        (SELECT count(votes.id) FROM votes WHERE votes.type='Bite' and votes.recipe_id=recipes.id and votes.created_at > '#{time}') AS recent_bites
      FROM recipes ORDER BY recipes.created_at) AS data
      WHERE recent_bites > 0 ORDER BY recent_bites #{order}"
    if !page.nil? && !per_page.nil?
      self.paginate_by_sql(sql, page: page, per_page: per_page)
    else
      self.find_by_sql(sql)
    end
  end

end
