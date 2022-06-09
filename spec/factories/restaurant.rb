# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }
    location { 'Islamabad' }
  end
end
