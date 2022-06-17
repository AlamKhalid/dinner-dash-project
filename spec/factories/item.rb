# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  category = FactoryBot.create(:category)

  factory :item do
    categories { [category] }
    association :restaurant
    name { Faker::Food.name }
    description { 'A fresh and hot burger served with fries' }
    price { 200 }
  end

  factory :item_2, class: Item do
    categories { [category] }
    association :restaurant
    name { Faker::Food.name }
    description { 'A fresh and hot burger served with fries' }
    price { 200 }
  end
end
