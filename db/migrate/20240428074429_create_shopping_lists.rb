class CreateShoppingLists < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_lists do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true
      t.string :name
      t.float :quantity
      t.float :price

      t.timestamps
    end
  end
end
