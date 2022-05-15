# frozen_string_literal: true

class CartOrderItem < ApplicationRecord
  belongs_to :cart_order
  belongs_to :item

  validates :item_id, :quantity, :type, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
