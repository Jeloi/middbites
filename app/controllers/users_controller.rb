class UsersController < ApplicationController
	before_action :set_user, :set_user_votes
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

  private
    def set_user
      @user = User.find(params[:id])
    end
end
