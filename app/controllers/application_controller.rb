class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_filter :set_session_return_path
  before_filter :update_sanitized_params, if: :devise_controller?

  # before_filter :cancan_bug_fix

  # For Devise's strong parameters
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :password, :email, :password_confirmation)}
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:username, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) << [:email, :username, :bio]
  end

  # Devise - redirect to a specific page on successful sign in 
  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      edit_user_registration_path
    else
      root_path
     # session[:return_to] || root_path
     # logger.debug { session[:return_to] }
    end
  end

  # Can can rescue exception with
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # CanCan and Rails 4 bug workaround
  def cancan_bug_fix
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  private

  # --- Before filters ---

  # Not used currently
  def restrict_unconfirmed_users
    if user_signed_in? && !current_user.confirmed?
      redirect_to edit_user_registration_path, error: "You must confirm your account to do that."
    end  
  end

  def set_session_return_path
    session[:return_to] = request.fullpath
    # logger.debug { session[:return_to] }
  end

  # Load arrays of current_user's bites and fav ids
  def set_user_votes
    if user_signed_in?
      @user_bites = current_user.bites.pluck(:recipe_id)
      @user_favs = current_user.favorites.pluck(:recipe_id)
    end
  end

  def set_per_page
    @per_page = 24
  end


  def set_recipe_sort
    case params[:sort]
    when "name"
      @sort = :title
    when "popularity"
      @sort = :score
    when "date"
      @sort = :created_at
    when "chatter"
      @sort = :comments_count
    else
      @sort = :title
    end
  end

end
