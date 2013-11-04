class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :recipe, index: true, null: false
      t.references :user, index: true, null: false
      t.integer :recipe_owner_id, null: false
      t.string :type

      t.timestamps
    end
  end
end
