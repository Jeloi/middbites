class ItemsController < ApplicationController
	# layout 'items', except: :show #doesn't seem to perform correctly

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
  	respond_to do |wants|
  		wants.html { render :layout => 'application' }
  	end
  end
end
