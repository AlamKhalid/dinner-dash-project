# frozen_string_literal: true

# Represents both, cart and order
class CreateCartOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_orders do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :status
      t.decimal :total_price, default: 0.0
      t.string :type, null: false

      t.timestamps
    end
  end
end
