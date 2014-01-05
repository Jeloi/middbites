class TagsController < ApplicationController
  def all_tags
  	@tags = Tag.all
  end

  def grouped_tags
  end
end
