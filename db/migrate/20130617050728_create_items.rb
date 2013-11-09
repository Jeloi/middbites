class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
			t.string	:name, null: false
			t.references :item_category, null: false
      t.timestamps
    end
  end
end
