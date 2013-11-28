# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string(50)       default("")
#  comment          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  role             :string(255)      default("comments")
#  created_at       :datetime
#  updated_at       :datetime
#

require "spec_helper"


describe Comment do
  it "should set its user_handle on create" do
  	recipe  = create(:recipe, :with_ingredients, :owned)
  	User.first.update_attributes(handle: "coolgirl6")
  	recipe.comments.create(comment: "text comment", user_id: User.first.id)
  	comment = recipe.comments.first
  	expect(comment.user_handle).to 	eql "coolgirl6"
  end
end


