class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # Helper methods made available in views
  helper_method :current_user, :logged_in?
  
  protect_from_forgery with: :exception


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def user_logged_in?
    unless logged_in?
      redirect_to root_path, notice: "You must be signed in to do that!"
    end
  end

end
