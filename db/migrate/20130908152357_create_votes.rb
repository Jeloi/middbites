class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :recipe, index: true
      t.references :user, index: true
      t.integer :recipe_owner_id
      t.string :type

      t.timestamps
    end
  end
end
