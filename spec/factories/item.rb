# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :item do
    categories { [FactoryBot.create(:category)] }
    association :restaurant
    name { Faker::Food.name }
    description { 'A fresh and hot burger served with fries' }
    price { 200 }
  end
end
