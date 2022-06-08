# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    categories { [FactoryBot.create(:category)] }
    association :restaurant
    name { 'Burger' }
    description { 'A fresh and hot burger served with fries' }
    price { 200 }
  end
end
