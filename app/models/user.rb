# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_code      :string(255)
#  confirmed              :boolean          default(FALSE)
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  image                  :string(255)
#  username               :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :validatable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  # Constants
  BIO_LENGTH = 140

	# Associations
	has_many :recipes, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :bites, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_recipes, through: :favorites, source: :recipe
	has_many :bit_recipes, through: :bites, source: :recipe

	# Validations
	validates_format_of :username, :with => /\A[a-zA-Z0-9.-_]+\Z/, message: "may only contain: a-z, A-Z, 0-9 and ._-"
	validates_presence_of :username, :message => "can't be blank"
	validates_uniqueness_of :username, :message => "is already taken", case_sensitive: false

	# Send confirmation email after create
	after_create :send_confirmation_instructions

	# Instance Methods

	# Return the user's username if exists, otherwise return the name (from omniauth)
	def handle_name
		if !self.read_attribute(:username).blank?
			self.username
		else
			self.name
		end
	end

	# Return the user's recipes, ordered by score with highest rated first
	def top_recipes
		self.recipes.order(score: :desc)
	end

	# Return the user's recipes, ordered by most recent
	def recent_recipes
		self.recipes.order(created_at: :desc)
	end

 ####### UNTESTED METHODS FOR USERS' SCORES #####

 	#! Returns a boolean representing whether or not the user voted the given recipe, through the given association (bite, favorite). Does not use eager loading!
 	def voted_on? recipe, association
 		self.send(association).where(recipe_id: recipe.id).any?
 	end

 	# Accept a recipe and association (votes), and create a new vote for this user on the recipe
 	def vote recipe, association
 		if (["bites", "favorites"].include? association) && !self.voted_on?(recipe, association)
 			self.send(association).create(recipe_id: recipe.id, recipe_owner_id: recipe.user_id)
 		else
 			raise "Wrong type of association provided"
 		end
 	end

 	# Accept a recipe and association (votes), and deletes the vote for this user on the recipe
 	def unvote recipe, association
 		if (["bites", "favorites"].include? association) && self.voted_on?(recipe, association)
 			self.send(association).where(recipe_id: recipe.id).destroy_all
 		else
 			raise "Wrong type of association provided"
 		end
 	end


	# Class Methods

	# Omniauth
	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_create do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.username = auth.info.name.downcase.tr!(" ", "_")
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.image = auth.info.image
	  end
	end

	def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end
	end


	# --- Devise helpers ---

	def update_with_password(params, *options)
	  if encrypted_password.blank?
	    update_attributes(params, *options)
	  else
	    super
	  end
	end

	def password_required?
		super && provider.blank?
	end
	
	def confirmation_required?
	  false
	end

	def resource_name
	  :user
	end
	
	def resource
	  @resource ||= User.new
	end
	
	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end

end
