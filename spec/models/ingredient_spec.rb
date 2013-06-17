# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  item_id    :integer
#  quantity   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Ingredient do
  pending "add some examples to (or delete) #{__FILE__}"
end
