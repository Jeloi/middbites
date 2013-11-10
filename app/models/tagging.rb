class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :recipe

  validates :tag_id, :uniqueness => {scope: :recipe_id}
end
