class ItemsController < ApplicationController
  layout nil
	layout 'items', :except => :show #doesn't seem to perform correctly

  before_action :set_recipe_sort, only: [:show]
  before_action :set_per_page, :set_user_votes, only: [:show]



  def alphabetical
  	# Group items in a hash with keys being the first char of item's name
  	@grouped_items = Item.all.group_by { |item| item.name[0].upcase }
  	@groups = @grouped_items.keys.sort
  	respond_to do |wants|
  		wants.html { render "items/grouped_items" }
  	end
  end

  def categorized
  	@item_categories = ItemCategory.includes(:items)
  end

  def popular
  	@items = Item.where("ingredients_count> 0").order(ingredients_count: :desc)
  end
  
  def show
  	@item = Item.find(params[:id])
    @header = @item.name
    @blurb = "#{@item.recipes.count} recipes for this ingredient"
    @view = params[:view] || "detailed"
    order = (params[:order] == 'asc' ? :asc : :desc)
    logger.debug { @sort }
    @recipes = @item.recipes.order(@sort => order).paginate(:page => params[:page], :per_page => @per_page)
  	respond_to do |wants|
  		wants.html { render "recipes/recipes.html.erb", layout: "application.html.erb" }
  	end
  end


end
