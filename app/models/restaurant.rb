# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :items
  has_many :cart_orders

  validates :name, :location, presence: true
  validates :name, uniqueness: true

  scope :restaurant_with_items, -> { includes(:items).order(:id).all }
end
