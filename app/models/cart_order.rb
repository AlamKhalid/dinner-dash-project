# frozen_string_literal: true

class CartOrder < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :cart_order_items, dependent: :destroy
  has_many :items, through: :cart_order_items
end
