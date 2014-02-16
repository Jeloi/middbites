class TagsController < ApplicationController

	before_action :set_recipe_sort, only: [:show]
	before_action :set_per_page, :set_user_votes, only: [:show]
	
  def all
  	@tags = Tag.all.order(taggings_count: :desc)
  end

  def grouped
  	@tag_categories = TagCategory.includes(:tags)
  end

  def show
  	@tag = Tag.find(params[:id])
    @header = @tag.name
    @blurb = "#{@tag.recipes.count} recipes tagged with \"#{@tag.name}\""
    @view = params[:view] || "detailed"
    order = (params[:order] == 'asc' ? :asc : :desc)
    logger.debug { @sort }
    @recipes = @tag.recipes.order(@sort => order).paginate(:page => params[:page], :per_page => @per_page)
  	respond_to do |wants|
  		wants.html { render "recipes/recipes.html.erb", layout: "application.html.erb" }
  	end
  end
end
