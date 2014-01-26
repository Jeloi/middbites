class PagesController < ApplicationController
  def home
  	
  end

  def about
  end

  def menus

		@menus_hash = MenuScraper.scrape_midd_menus("http://menus.middlebury.edu", params[:date], params[:sort_by])
		# MenuScraper.generate_items_from_meals("http://menus.middlebury.edu", params[:date])
		logger.debug { @menus_hash }
    @current_meal = "Dinner"
  end
end
