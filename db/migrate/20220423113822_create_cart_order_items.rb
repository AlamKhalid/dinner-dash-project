class CreateCartOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_order_items do |t|
      t.references :cart_order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity
      t.string :type

      t.timestamps
    end
  end
end
