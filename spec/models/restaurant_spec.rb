# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { FactoryBot.create :restaurant }

  describe '.creation' do
    context 'when valid' do
      it 'can be created' do
        expect(restaurant).to be_valid
      end
    end

    context 'when invalid' do
      it 'cannot be created without name' do
        restaurant.name = nil
        expect(restaurant).not_to be_valid
      end

      it 'cannot be created without location' do
        restaurant.location = nil
        expect(restaurant).not_to be_valid
      end
    end
  end

  describe '.association' do
    context 'with valid associations' do
      it 'has many items' do
        expect(restaurant).to have_many(:items)
      end

      it 'has many cart_orders' do
        expect(restaurant).to have_many(:cart_orders)
      end
    end
  end

  describe '.uniqueness' do
    context 'when name is unique' do
      it 'is valid' do
        expect(restaurant).to validate_uniqueness_of(:name)
      end
    end
  end
end
