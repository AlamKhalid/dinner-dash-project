# frozen_string_literal: true

FactoryBot.define do
  factory :cart_order do
    association :user
    association :restaurant
    type { 'CartOrder' }
    total_price { 100 }
  end
end
