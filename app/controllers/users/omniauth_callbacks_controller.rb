class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :set_session_return_path
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.debug { @user }
    if @user.persisted?
      if !resource.confirmed?
        redirect_to new_user_session_path
        flash[:alert] = "Your account has not been confirmed yet! See below if you need help confirming your account."
      else
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      end
    else
      session["devise.user_attributes"] = @user.attributes
      # logger.debug { session["devise.facebook_data"] }
      redirect_to new_user_registration_url, notice: "Successfully authenticated with Facebook. We just need to confirm your middlebury email and you're good to go!"
    end
  end

  # alias_method :facebook, :all
end