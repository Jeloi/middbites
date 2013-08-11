class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :directions
      t.string :title
      t.string :blurb
      t.references :user

      t.timestamps
    end
  end
end
