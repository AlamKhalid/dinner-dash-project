class AddRestaurantIdToCartOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_orders, :restaurant, foreign_key: true
  end
end
