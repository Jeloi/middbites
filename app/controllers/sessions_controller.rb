class SessionsController < ApplicationController

	skip_before_filter :set_session_return_path

	def create
		user = User.from_omniauth(env["omniauth.auth"])
		# render :text => request.env["omniauth.auth"].to_yaml
		session[:user_id] = user.id
		flash[:notice] = "Succesfully signed in through Facebook!"
		redirect_to request.env['omniauth.origin'] || session[:return_to] || root_path
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have logged out of your Facebook account."
		redirect_to session[:return_to] || root_path
	end

end
