class Vote < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates_presence_of :recipe_id, :user_id, :on => :save, :message => "can't be blank"
  
end
