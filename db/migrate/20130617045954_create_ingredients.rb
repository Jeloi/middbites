class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
			t.references :recipe
			t.references :item
			t.string :quantity
      t.timestamps
    end
  end
end
