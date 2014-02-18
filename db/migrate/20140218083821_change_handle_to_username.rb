class ChangeHandleToUsername < ActiveRecord::Migration
  def change
  	rename_column :users, :handle, :username
  end
end
