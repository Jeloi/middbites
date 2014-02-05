class AddIngredientsCounterToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients_count, :integer, default: 0 
  end
end
