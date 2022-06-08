# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { FactoryBot.build :restaurant }
  let(:restaurant_dup) { FactoryBot.build :restaurant }

  # it 'is valid if the name is unique' do
  #     expect(subject).to be_valid
  # end

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
        items = described_class.reflect_on_association(:items)
        expect(items.macro).to eq(:has_many)
      end

      it 'has many cart_orders' do
        cart_orders = described_class.reflect_on_association(:cart_orders)
        expect(cart_orders.macro).to eq(:has_many)
      end
    end
  end

  describe '.uniqueness' do
    context 'when name is not unique' do
      it 'is invalid' do
        restaurant.save
        expect(restaurant_dup).to be_invalid
      end
    end

    context 'when name is unique' do
      it 'is valid' do
        restaurant_dup.name = 'Res2'
        restaurant.save
        expect(restaurant_dup).to be_valid
      end
    end
  end
end
