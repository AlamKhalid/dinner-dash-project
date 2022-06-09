# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartOrderItem, type: :model do
  let(:cart_order_item) { FactoryBot.create :cart_order_item }

  describe '.creation' do
    context 'when valid' do
      it 'can be created' do
        expect(cart_order_item).to be_valid
      end
    end

    context 'when invalid' do
      it 'cannot be created without item' do
        cart_order_item.item_id = nil
        expect(cart_order_item).not_to be_valid
      end

      it 'cannot be created without type' do
        cart_order_item.type = nil
        expect(cart_order_item).not_to be_valid
      end

      it 'cannot be created without quantity' do
        cart_order_item.quantity = nil
        expect(cart_order_item).not_to be_valid
      end
    end
  end

  describe '.association' do
    context 'with valid associations' do
      it 'belongs to an item' do
        expect(cart_order_item).to belong_to(:item)
      end

      it 'belongs to a cart_order' do
        expect(cart_order_item).to belong_to(:cart_order)
      end
    end
  end

  describe '.uniqueness' do
    context 'when item and cart order pair is unique' do
      it 'is valid' do
        expect(cart_order_item).to validate_uniqueness_of(:item_id).scoped_to(:cart_order_id)
      end
    end
  end

  describe '.validations_quantity' do
    context 'when quantity is less than 0' do
      it 'is invalid' do
        cart_order_item.quantity = -1
        expect(cart_order_item).to be_invalid
      end
    end

    context 'when quantity is not numeric' do
      it 'is invalid' do
        cart_order_item.quantity = 'abc'
        expect(cart_order_item).to be_invalid
      end
    end

    context 'when quantity is integer' do
      it 'is valid' do
        cart_order_item.quantity = 2
        expect(cart_order_item).to be_valid
      end
    end

    context 'when quantity is double' do
      it 'is invalid' do
        cart_order_item.quantity = 2.0
        expect(cart_order_item).not_to be_valid
      end
    end
  end
end
