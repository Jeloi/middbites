class RecipesController < ApplicationController
  load_and_authorize_resource find_by: :slug, except: [:vote, :unvote, :create]

  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :vote, :unvote]
  before_action :set_items, only: [:new, :create, :update, :edit]
  before_action :set_per_page, :set_user_votes, only: [:index, :popular, :recent, :top]
  before_action :set_recipe_sort, only: [:index]

  skip_before_action :set_session_return_path, only: [:create, :update, :destroy, :vote, :unvote]

  def index
    @header = "All Recipes"
    @blurb = "Showing all #{Recipe.all.count} Recipes"
    @view = params[:view] || "detailed"
    order = (params[:order] == 'asc' ? :asc : :desc)
    @recipes = Recipe.order(@sort => order).paginate(:page => params[:page], :per_page => @per_page)
    respond_to do |wants|
      wants.html { render "recipes.html.erb" }
      wants.js { render "recipes.js.erb" }
    end
  end

  def top
    @header = "Top Recipes"
    @blurb = "The Top 10 highest rated recipes of all time"
    @view = params[:view] || "detailed"
    @recipes = Recipe.order(score: :desc, created_at: :asc).limit(10)
    respond_to do |wants|
      wants.html { render "recipes.html.erb" }
      wants.js { render "recipes.js.erb" }
    end
  end

  def popular
    @header = "Popular Now"
    @blurb = "Recipes that have been receiving votes recently"
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
    authorize! :create, Recipe
    @recipe = current_user.recipes.build(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Your recipe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        # Recreate tag_ids artifically through taggings_attributes (for redirecting to form)
        tag_ids = recipe_params["taggings_attributes"].values.map { |x| x["tag_id"] if (x["_destroy"] == "false") }.compact if recipe_params["taggings_attributes"]
        @recipe.tag_ids = tag_ids
        # logger.debug { @recipe.taggings }
        logger.debug { @recipe.errors }
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
      format.html { redirect_to recipes_path, notice: 'Your recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # POST /recipes/1/vote
  def vote
    authorize! :vote, Recipe
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
    authorize! :unvote, Recipe
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


    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:remove_image, :image, :directions, :title, :blurb, ingredients_attributes: [:item_id, :quantity, :_destroy, :id], taggings_attributes: [:_destroy, :tag_id, :id])
    end
end
