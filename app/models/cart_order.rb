# frozen_string_literal: true

class CartOrder < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :cart_order_items, dependent: :destroy
  has_many :items, through: :cart_order_items

  validates :id, uniqueness: { scope: :user_id }, if: ->(cart_order) { cart_order.type == 'Cart' }
  validates :user_id, :total_price, :type, :restaurant_id, presence: true
  validates :total_price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                          numericality: { greater_than: 0, less_than: 1_000_000 }
end
