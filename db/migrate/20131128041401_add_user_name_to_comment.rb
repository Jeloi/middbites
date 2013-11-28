class AddUserNameToComment < ActiveRecord::Migration
  def change
    add_column :comments, :user_handle, :string
    add_column :users, :handle, :string
  end
end
