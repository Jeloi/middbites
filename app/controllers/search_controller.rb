class SearchController < ApplicationController
  def search
  	everything = (params[:context] == "Everything")
  	@total_results = 0
  	if everything || params[:context] == "Tags"
  		@tag_results = Tag.search do
  			keywords params[:keywords] do
  				minimum_match 1
  				query_phrase_slop 1
	  		end
  		end.results
  		logger.debug { "Tags: " + @tag_results.size.to_s }
  		@total_results += @tag_results.size
  	end
  	if everything || params[:context] == "Recipes"
  		@recipe_results = Recipe.search do
  			keywords params[:keywords] do
  				minimum_match 1
  			end
  		end.results
  		logger.debug { "Recipes: " + @recipe_results.size.to_s }
  		@total_results += @recipe_results.size
  	end
  	if everything || params[:context] == "Ingredients"
  		@item_results = Item.search do
  			keywords params[:keywords] do
  				minimum_match 1
  			end
  		end.results
  		logger.debug { @item_results }
  		@total_results += @item_results.size
  	end
  	logger.debug { @total_results }
  end
end
