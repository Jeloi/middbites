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
#  user_handle      :string(255)
#

class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :user
  belongs_to :commentable, :polymorphic => true, counter_cache: true

  default_scope -> { order('created_at ASC') }

  # Callbacks
  before_save	:set_user_handle

  # Set the user_name attribute for this comment
  def set_user_handle
  	self.user_handle = self.user.handle
  end

end
