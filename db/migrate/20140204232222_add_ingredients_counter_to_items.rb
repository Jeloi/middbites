class AddIngredientsCounterToItems < ActiveRecord::Migration
  def change
    add_column :items, :ingredients_count, :integer, default: 0 
  end
end
