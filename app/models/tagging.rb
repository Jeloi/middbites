# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tagging < ActiveRecord::Base
  belongs_to :tag, counter_cache: true
  belongs_to :recipe

  # validates :tag_id, :uniqueness => {scope: :recipe_id}
end
