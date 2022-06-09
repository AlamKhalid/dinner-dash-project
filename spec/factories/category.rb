# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::Color.name }
  end
end
