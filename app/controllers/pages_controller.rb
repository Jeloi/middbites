class PagesController < ApplicationController
  def home
  	
  end

  def about
  end

  def menus

		@menus_hash = MenuScraper.scrape_midd_menus("http://menus.middlebury.edu", params[:date], params[:sort_by])
		# logger.debug { @menus_hash }
  end
end
