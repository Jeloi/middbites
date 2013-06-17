class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :directions
      t.user :references
      t.recipe_category :references

      t.timestamps
    end
  end
end
