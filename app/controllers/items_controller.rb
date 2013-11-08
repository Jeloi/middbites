class ItemsController < ApplicationController
  def all
  	@items = Item.all
  end

  def show
  end

  def item_category
  end
end
