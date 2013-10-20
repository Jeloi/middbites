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
#

class User < ActiveRecord::Base
	# Associations
	has_many :recipes
	
	# Validations
	validates_presence_of :name, message: "can't be blank"

	# Instance Methods


 ####### UNTESTED METHODS FOR USERS' SCORES #####

	# Returns all favorites that have been made on a recipe this user owns
	def favorites_on_owned_recipes
		Favorite.joins(:recipe).joins(:user).where(recipes: {user_id: id})
	end
	
	# Returns all bites that have been made on a recipe this user owns
	def bites_on_owned_recipes
		Bite.joins(:recipe).joins(:user).where(recipes: {user_id: id})
	end

	# Returns all comments that have been made on a recipe this user owns
	def comments_on_owned_recipes
		Comment.joins(:recipe).joins(:user).where(recipes: {user_id: id})
	end


	# Class Methods

	# Omniauth
	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.first_name = auth.info.first_name
	    user.last_name = auth.info.last_name
	    user.image = auth.info.image
	    user.save!
	  end
	end

	def anything
		
	end
	
end
