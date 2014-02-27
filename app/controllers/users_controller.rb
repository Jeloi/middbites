class UsersController < ApplicationController
	before_action :set_user, except: [:unconfirmed_email_change, :unconfirmed_omniauth_email_change, :wrong_email]
  before_action :set_user_votes
  before_action :set_recipe_sort, only: [:recipes]

  def show
    @top_recipes = @user.top_recipes.limit(3)
    @recent_recipes = @user.recent_recipes.limit(3)
    logger.debug { @top_recipes }
    logger.debug { @recent_recipes }
  end

  def bites
    @header = (@user == current_user ? "Your" : @user.handle_name + "'s") + " Bites"
    @recipes = @user.bit_recipes.order(created_at: :desc)
    respond_to do |wants|
      wants.html { render 'votes.html.erb' }
    end
  end

  def favorites
    @header = (@user == current_user ? "Your" : @user.handle_name + "'s") + " Favorites"
    @recipes = @user.favorite_recipes.order(created_at: :desc)
    respond_to do |wants|
      wants.html { render 'votes.html.erb' }
    end
  end

  def recipes
    @header = (@user == current_user ? "Your" : @user.handle_name + "'s") + " Recipes"
    @view = params[:view] || "detailed"
    order = (params[:order] == 'asc' ? :asc : :desc)
    @recipes = @user.recipes.order(@sort => order).paginate(:page => params[:page], :per_page => @per_page)
    respond_to do |wants|
      wants.html { render "recipes/recipes.html.erb" }
      wants.js { render "recipes/recipes.js.erb" }
    end
  end

  def preconfirm
    @resource = @user
    @token = params[:token]
    @email = params[:email]
    respond_to do |wants|
      wants.html { render "preconfirm", layout: "bare" }
    end
  end

  def wrong_email
  end

  def unconfirmed_email_change
    @user = User.find_by(username: params[:username])
    if !@user.nil? && @user.valid_password?(params[:password])
      logger.debug { "correct password" }
      @user.email = params[:email]
      if @user.save
        redirect_to new_user_session_path, notice: "A confirmation has been sent to your newly specified email address: #{params[:email]}"
      else
        redirect_to :back, flash: {error: "#{params[:email]} is not a valid middlebury email address."}
      end
    else
      redirect_to :back, flash: {error: "Incorrect username/password combination"}
    end
  end

  def unconfirmed_omniauth_email_change
    @user = User.new(email: params[:email])
    unless !@user.errors.get(:email).nil?
      session[:tmp_user_email] = params[:email]
      redirect_to user_omniauth_authorize_path(:facebook)
    else
      redirect_to :back, flash: {error: "#{params[:email]} is not a valid middlebury email address."}
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
