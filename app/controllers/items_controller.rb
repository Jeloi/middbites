class ItemsController < ApplicationController

  def alphabetical
  	# Group items in a hash with keys being the first char of item's name
  	@grouped_items = Item.all.group_by { |item| item.name[0].upcase }
  	@groups = @grouped_items.keys.sort
  	respond_to do |wants|
  		wants.html { render "items/grouped_items" }
  	end
  end

  def categorized
  	# Could have used ItemCategory.includes(:items). Kept same format as alphabetical action instead
  	# @grouped_items = Item.all.group_by { |item| item.item_category.name }
  	# @groups = @grouped_items.keys
  	@item_categories = ItemCategory.includes(:items)
  end

  def popular
  	
  end
  
  def all
  	@items = Item.all.order(name: :asc)
  end

  def show
  	@item = Item.find(params[:id])
  end
end
