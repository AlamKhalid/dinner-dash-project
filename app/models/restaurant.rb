# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :items
  has_many :cart_orders

  validates :name, :locaiton, presence: true
  validates :name, uniqueness: true
end
