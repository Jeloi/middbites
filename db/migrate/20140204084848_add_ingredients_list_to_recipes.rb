class AddIngredientsListToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients_list, :string, default: ""
    remove_column :recipes, :temperature
  end
end
