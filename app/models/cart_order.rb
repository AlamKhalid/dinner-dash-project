class CartOrder < ApplicationRecord
  belongs_to :user
  has_many :cart_order_items, dependent: :destroy
  has_many :items, through: :cart_order_items
end
