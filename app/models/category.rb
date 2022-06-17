# frozen_string_literal: true

class Category < ApplicationRecord
  has_and_belongs_to_many :items

  validates :name, presence: true
  validates :name, uniqueness: true
end
