# frozen_string_literal: true

class Item < ApplicationRecord
  after_find :add_item_picture_url

  belongs_to :restaurant
  has_and_belongs_to_many :categories
  has_many :cart_order_items
  has_many :cart_orders, through: :cart_order_items
  has_one_attached :item_picture, dependent: :destroy

  validates :name, :description, :price, presence: true
  validates :categories, length: { minimum: 1 }
  validates :name, uniqueness: true
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                    numericality: { greater_than: 0 }

  scope :restaurant_items, ->(restaurant_id) { where(restaurant_id: restaurant_id) }
  scope :not_retired, -> { where(retired: false) }
  scope :order_items, -> { includes(:cart_order_items).where(cart_order_items: { type: 'OrderItem' }) }
  scope :filter_category, ->(category_name) { includes(:categories).where(categories: { name: category_name }) }

  def add_item_picture_url
    self.item_picture_url = item_picture.attached? ? item_picture.service_url : ''
  end
end
