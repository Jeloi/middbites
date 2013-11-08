# == Schema Information
#
# Table name: votes
#
#  id              :integer          not null, primary key
#  recipe_id       :integer          not null
#  user_id         :integer          not null
#  recipe_owner_id :integer          not null
#  type            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Vote < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates_presence_of :recipe_id, :user_id, :on => :save, :message => "can't be blank"
  validates_uniqueness_of :user_id, scope: [:recipe_id, :type]
  
end
