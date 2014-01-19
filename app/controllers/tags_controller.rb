class TagsController < ApplicationController
  def all
  	@tags = Tag.all.order(taggings_count: :desc)
  end

  def grouped
  	@tag_categories = TagCategory.all
  end
end
