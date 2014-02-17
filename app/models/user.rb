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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]
	# Associations
	has_many :recipes
	has_many :comments
	has_many :votes
	has_many :bites
	has_many :favorites
	has_many :favorite_recipes, through: :favorites, source: :recipe
	has_many :bit_recipes, through: :bites, source: :recipe
	# Validations
	validates_presence_of :handle, :message => "can't be blank", :if => :not_omniauth?
	validates_uniqueness_of :handle, :message => "that handle is already taken"

	def not_omniauth?
		self.uid.blank?
	end

	# Instance Methods
	def handle_name
		if !self.read_attribute(:handle).blank?
			self.handle
		else
			self.name
		end
	end

 ####### UNTESTED METHODS FOR USERS' SCORES #####

 	#! Returns a boolean representing whether or not the user voted the given recipe, through the given association (bite, favorite). Does not use eager loading!
 	def voted_on? recipe, association
 		self.send(association).where(recipe_id: recipe.id).any?
 	end

 	# Accept a recipe and association (votes), and create a new vote for this user on the recipe
 	def vote recipe, association
 		if ["bites", "favorites"].include? association
 			self.send(association).create(recipe_id: recipe.id, recipe_owner_id: recipe.user_id)
 		else
 			raise "Wrong type of association provided"
 		end
 	end

 	# Accept a recipe and association (votes), and deletes the vote for this user on the recipe
 	def unvote recipe, association
 		if ["bites", "favorites"].include? association
 			self.send(association).where(recipe_id: recipe.id).destroy_all
 		else
 			raise "Wrong type of association provided"
 		end
 	end


	# Class Methods

	# Omniauth
	def self.find_for_facebook_oauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.image = auth.info.image
	    user.save!
	  end
	end

	protected
	def confirmation_required?
	  false
	end

end
