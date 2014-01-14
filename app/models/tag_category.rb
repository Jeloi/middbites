# == Schema Information
#
# Table name: tag_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TagCategory < ActiveRecord::Base
	has_many :tags
	validates_uniqueness_of :name, :on => :save, :message => "must be unique"
end
