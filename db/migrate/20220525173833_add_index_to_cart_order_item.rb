# frozen_string_literal: true

class AddIndexToCartOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_index :cart_order_items, %i[cart_order_id item_id], unique: true
  end
end
