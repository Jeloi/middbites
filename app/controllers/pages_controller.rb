class PagesController < ApplicationController
  before_action :set_meal, only: [:menus]
  before_action :set_user_votes, only: [:menus]

  def home
  	
  end

  def about
  end

  def menus

		@menus_hash = MenuScraper.scrape_midd_menus("http://menus.middlebury.edu", params[:date], params[:sort_by])
		# MenuScraper.generate_items_from_meals("http://menus.middlebury.edu", params[:date])
		logger.debug { @menus_hash }
    @recent_recipes = Recipe.order(created_at: :desc).limit(4)
    
  end


  # Set the current meal to be active for menus based on time of day
  def set_meal
    if Time.zone.now > Time.zone.parse("2:00pm")
      @current_meal = "Dinner"
    elsif Time.zone.now > Time.zone.parse("10am")
      @current_meal = "Lunch"
    else
      @current_meal = "Breakfast"
    end
  end

end
