class Item < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :categories
  has_many :cart_order_items
  has_many :cart_orders, through: :cart_order_items
  has_one_attached :item_picture, dependent: :destroy

  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
            numericality: { greater_than: 0, less_than: 1000000 }
end