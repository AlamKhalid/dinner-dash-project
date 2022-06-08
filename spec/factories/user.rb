# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { 'Alam Khalid' }
    email { 'alam.khalid@devsinc.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
