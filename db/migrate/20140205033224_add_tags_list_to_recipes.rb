class AddTagsListToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :tags_list, :string, default: ""
  end
end
