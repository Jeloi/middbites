class AddCounterCacheColumns < ActiveRecord::Migration
  def change
  	add_column :recipes, :bites_count, :integer, :default => 0
  	add_column :recipes, :favorites_count, :integer, :default => 0
  	add_column :recipes, :comments_count, :integer, :default => 0
  end
end
