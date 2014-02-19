class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :set_session_return_path
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.debug { @user }
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      if !resource.confirmed?
        flash[:alert] = "Your account has not been confirmed yet! Go to the user edit page to resend a confirmation email."
      end
    else
      session["devise.user_attributes"] = @user.attributes
      # logger.debug { session["devise.facebook_data"] }
      redirect_to new_user_registration_url
    end
  end

  # alias_method :facebook, :all
end