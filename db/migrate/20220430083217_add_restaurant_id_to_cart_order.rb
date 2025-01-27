# frozen_string_literal: true

# Each order now belongs to one restaurant only
class AddRestaurantIdToCartOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_orders, :restaurant, foreign_key: true, null: false
  end
end
