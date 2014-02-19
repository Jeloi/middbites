class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :set_session_return_path
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.user_attributes"] = @user.attributes
      logger.debug { session["devise.facebook_data"] }
      redirect_to new_user_registration_url
    end
  end

  # alias_method :facebook, :all
end