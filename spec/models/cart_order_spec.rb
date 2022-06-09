# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartOrder, type: :model do
  let(:cart_order) { FactoryBot.create :cart_order }

  describe '.creation' do
    context 'when valid' do
      it 'can be created' do
        expect(cart_order).to be_valid
      end
    end

    context 'when invalid' do
      it 'cannot be created without user' do
        cart_order.user_id = nil
        expect(cart_order).not_to be_valid
      end

      it 'cannot be created without restaurant' do
        cart_order.restaurant_id = nil
        expect(cart_order).not_to be_valid
      end

      it 'cannot be created without price' do
        cart_order.total_price = nil
        expect(cart_order).not_to be_valid
      end

      it 'cannot be created without type' do
        cart_order.type = nil
        expect(cart_order).not_to be_valid
      end
    end
  end

  describe '.validations_total_price' do
    context 'when price is less than 0' do
      it 'is invalid' do
        cart_order.total_price = -1
        expect(cart_order).to be_invalid
      end
    end

    context 'when price is not numeric' do
      it 'is invalid' do
        cart_order.total_price = 'abc'
        expect(cart_order).to be_invalid
      end
    end

    context 'when price is integer' do
      it 'is valid' do
        cart_order.total_price = 200
        expect(cart_order).to be_valid
      end
    end

    context 'when price is double' do
      it 'is valid' do
        cart_order.total_price = 200.0
        expect(cart_order).to be_valid
      end
    end
  end

  describe '.association' do
    context 'with valid associations' do
      it 'has many items' do
        expect(cart_order).to have_many(:items).through(:cart_order_items)
      end

      it 'has many cart_order_items' do
        expect(cart_order).to have_many(:cart_order_items).dependent(:destroy)
      end

      it 'belongs to a restaurant' do
        expect(cart_order).to belong_to(:restaurant)
      end

      it 'belongs to a user' do
        expect(cart_order).to belong_to(:user)
      end

    end
  end
end
