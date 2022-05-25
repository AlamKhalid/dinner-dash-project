# frozen_string_literal: true

class CartOrderItem < ApplicationRecord
  belongs_to :cart_order
  belongs_to :item

  validates :item_id, uniqueness: { scope: :cart_order_id }
  validates :item_id, :quantity, :type, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
