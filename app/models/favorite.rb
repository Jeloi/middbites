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

class Favorite < Vote
	belongs_to :recipe, counter_cache: true
end
