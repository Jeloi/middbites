class Users::SessionsController < Devise::SessionsController
  skip_before_filter :set_session_return_path

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    if !resource.confirmed?
      flash[:alert] = "Your account has not been confirmed yet! Go to the user edit page to resend a confirmation email."
    end
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

end