class SessionsController < ApplicationController

	def create
		user = User.from_omniauth(env["omniauth.auth"])
		# render :text => request.env["omniauth.auth"].to_yaml
		session[:user_id] = user.id
		flash[:notice] = "Succesfully signed in through Facebook!"
		redirect_to root_url
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have logged out of your Facebook account."
		redirect_to root_url
	end

end
