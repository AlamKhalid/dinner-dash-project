class CartOrderItem < ApplicationRecord
  belongs_to :cart_order
  belongs_to :item
end