# == Schema Information
#
# Table name: item_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ItemCategory < ActiveRecord::Base
end
