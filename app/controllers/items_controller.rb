class ItemsController < ApplicationController
  def all
  	@items = Item.all
  end

  def show
  	@item = Item.find(params[:id])
  end

  def item_category
  end
end
