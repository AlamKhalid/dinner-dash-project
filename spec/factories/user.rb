# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
  end

  factory :admin, class: User do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    role { 1 }
    password { '123456' }
  end
end
