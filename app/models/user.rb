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
         :recoverable, :rememberable, :trackable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]
	# Associations
	has_many :recipes, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :bites, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_recipes, through: :favorites, source: :recipe
	has_many :bit_recipes, through: :bites, source: :recipe
	# Validations
	validates_presence_of :username, :message => "can't be blank", :if => :not_omniauth?
	validates_uniqueness_of :username, :message => "that username is already taken"

	def not_omniauth?
		self.uid.nil?
	end

	# Instance Methods
	def handle_name
		if !self.read_attribute(:username).blank?
			self.username
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
