class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :set_session_return_path
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.debug { @user.errors.first }
    if @user.persisted?
      # This was old logic for confirming omniauth accounts with a new email
      if !resource.confirmed? && session[:tmp_user_email]
        email = session[:tmp_user_email]
        session.delete(:tmp_user_email)
        @user.email = email
        @user.save
        flash[:notice] = "A confirmation has been sent to your newly specified email address: #{email}"
        redirect_to new_user_session_path
      else
        flash[:welcome] = "Successfully signed up. You can now vote on and create recipes. Welcome to Middbites!" if (@user.sign_in_count == 1)
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