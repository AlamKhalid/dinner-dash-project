# frozen_string_literal: true

class CreateCartOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_order_items do |t|
      t.references :cart_order, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
