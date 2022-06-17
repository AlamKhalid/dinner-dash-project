# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    association :user
    association :restaurant
    type { 'Cart' }
    total_price { 200 }
  end
end
