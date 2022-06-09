# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user
    association :restaurant
    status { 0 }
    type { 'Order' }
    total_price { 100 }
  end
end
