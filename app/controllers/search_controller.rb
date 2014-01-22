class SearchController < ApplicationController

  before_action :set_user_votes

  def search
    @view = params[:view] || "detailed"
  	everything = (params[:context] == "Everything")
  	@total_results = 0
  	if everything || params[:context] == "Tags"
  		@tags = Tag.search do
  			keywords params[:keywords] do
  				minimum_match 1
  				query_phrase_slop 1
	  		end
  		end.results
  		logger.debug { "Tags: " + @tags.size.to_s }
  		@total_results += @tags.size
  	end
  	if everything || params[:context] == "Recipes"
  		@search = Recipe.search do
        paginate :page => (params[:page] || 1), :per_page => 24 
        keywords params[:keywords] do
          minimum_match 1
  			end
  		end
      @recipes = @search.results
  		logger.debug { "Recipes: " + @recipes.size.to_s }
  		@total_results += @search.total
  	end
  	if everything || params[:context] == "Ingredients"
  		@items = Item.search do
  			keywords params[:keywords] do
  				minimum_match 1
  			end
  		end.results
  		logger.debug { "Ingredients: " + @items.size.to_s }
  		@total_results += @items.size
  	end
  	logger.debug { @total_results }
  end
end
