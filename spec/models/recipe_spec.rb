# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  directions         :text
#  user_id            :integer
#  recipe_category_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Recipe do
  it "should make 3 equal 3" do
  	3 == 3
  end
end
