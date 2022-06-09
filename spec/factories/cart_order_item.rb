# frozen_string_literal: true

FactoryBot.define do
  Faker::UniqueGenerator.clear

  factory :cart_order_item do
    association :item
    association :cart_order
    type { 'CartOrderItem' }
    quantity { 1 }
  end
end
