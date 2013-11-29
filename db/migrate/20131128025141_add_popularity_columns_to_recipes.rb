class AddPopularityColumnsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :score, :decimal, :default => 0.0, :precision => 18, :scale => 6
    add_column :recipes, :temperature, :decimal, :default => 0.0, :precision => 18, :scale => 6
  end
end
