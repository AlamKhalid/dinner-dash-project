# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    association :user
    association :restaurant
    type { 'Cart' }
    total_price { 100 }
  end
end
