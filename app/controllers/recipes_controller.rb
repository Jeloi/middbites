class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :vote, :unvote]
  before_action :set_items, only: [:new, :create, :update, :edit]
  before_action :set_per_page, :set_user_votes, only: [:index, :popular, :recent, :top]
  before_action :set_recipe_sort, only: [:index]
  before_action :user_logged_in?, only: [:edit, :create, :vote, :unvote, :destroy]

  def index
    @header = "All Recipes"
    @blurb = "Showing all #{Recipe.all.count} Recipes"
    @view = params[:view] || "detailed"
    order = (params[:order] == 'asc' ? :asc : :desc)
    order = :asc if @sort == :title
    @recipes = Recipe.order(@sort => order).paginate(:page => params[:page], :per_page => @per_page)
    respond_to do |wants|
      wants.html { render "recipes.html.erb" }
      wants.js { render "recipes.js.erb" }
    end
  end

  def top
    @header = "Top Recipes"
    @blurb = "The Top 30 highest rated recipes of all time"
    @view = params[:view] || "detailed"
    @recipes = Recipe.order(score: :desc, created_at: :asc).limit(30)
    respond_to do |wants|
      wants.html { render "recipes.html.erb" }
      wants.js { render "recipes.js.erb" }
    end
  end

  def popular
    @header = "Popular Now"
    @blurb = "Popular recipes receiving bites right now"
    @view = params[:view] || "detailed"
    @recipes = Recipe.popular_this_week(params[:page], @per_page)
    respond_to do |wants|
      wants.html { render "recipes.html.erb" }
      wants.js { render "recipes.js.erb" }
    end
  end

  def recent
    @header = "Recent Recipes"
    @blurb = "The latest recipes created in the last month"
    @view = params[:view] || "detailed"
    @recipes = Recipe.in_last_month.order(created_at: :desc).paginate(:page => params[:page], :per_page => @per_page)
    respond_to do |wants|
      wants.html { render "recipes.html.erb" }
      wants.js { render "recipes.js.erb" }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @comment = @recipe.comments.build
    logger.debug { params[:id].class }
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    # logger.debug { @grouped_item_options }
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Your recipe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Your recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  # POST /recipes/1/vote
  def vote
    @association = params[:association]
    respond_to do |format|
      if current_user.vote(@recipe, @association)
        @recipe.reload
        format.js { render "vote" }
      end
    end
  end

  # DELETE /
  def unvote
    @association = params[:association]
    respond_to do |format|
      if current_user.unvote(@recipe, @association)
        @recipe.reload
        format.js { render "unvote" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.friendly.find(params[:id])
    end

    def set_items
      # @items_json = Item.all.pluck(:name).to_json.html_safe
      # items = Item.all.collect {|i| [i.id, i.name]}
      # @items_hash = {}
      # items.each do |pair|
      #   @items_hash[pair[0]] = pair[1]
      # end
      # @items_hash = @items_hash.to_json.html_safe
      @grouped_item_options = ItemCategory.all. map do |cat|
        [cat.name, cat.items.collect {|i| [i.name, i.id]}]
      end
      # @grouped_item_options.unshift ["", [""]] # add a blank pair at the beginning
      # logger.debug { @grouped_item_options }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:remove_image, :image, :directions, :title, :blurb, :tag_list, ingredients_attributes: [:item_id, :quantity, :_destroy, :id], taggings_attributes: [:_destroy, :tag_id, :id])
    end
end
