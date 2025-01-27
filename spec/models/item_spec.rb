# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.create :item }

  describe '.creation' do
    context 'when valid' do
      it 'can be created' do
        expect(item).to be_valid
      end
    end

    context 'when invalid' do
      it 'cannot be created without name' do
        item.name = nil
        expect(item).not_to be_valid
        expect(item.errors).to include(:name)
      end

      it 'cannot be created without description' do
        item.description = nil
        expect(item).not_to be_valid
        expect(item.errors).to include(:description)
      end

      it 'cannot be created without price' do
        item.price = nil
        expect(item).not_to be_valid
        expect(item.errors).to include(:price)
      end
    end
  end

  describe '.validations_categories' do
    context 'without categories' do
      it 'is invalid' do
        item.categories = []
        expect(item).to be_invalid
        expect(item.errors).to include(:categories)
      end
    end

    context 'with categories' do
      it 'is valid' do
        item.categories = [FactoryBot.create(:category, name: 'Cat2')]
        expect(item).to be_valid
      end
    end
  end

  describe '.validations_price' do
    context 'when price is less than 0' do
      it 'is invalid' do
        item.price = -1
        expect(item).to be_invalid
        expect(item.errors).to include(:price)
      end
    end

    context 'when price is not numeric' do
      it 'is invalid' do
        item.price = 'abc'
        expect(item).to be_invalid
        expect(item.errors).to include(:price)
      end
    end

    context 'when price is integer' do
      it 'is valid' do
        item.price = 200
        expect(item).to be_valid
      end
    end

    context 'when price is double' do
      it 'is valid' do
        item.price = 200.0
        expect(item).to be_valid
      end
    end
  end

  describe '.uniqueness' do
    context 'when name is unique' do
      it 'is valid' do
        expect(item).to validate_uniqueness_of(:name)
      end
    end
  end

  describe '.association' do
    context 'with valid associations' do
      it 'has many cart_order_items' do
        expect(item).to have_many(:cart_order_items)
      end

      it 'has many cart_orders' do
        expect(item).to have_many(:cart_orders).through(:cart_order_items)
      end

      it 'belongs to a restaurant' do
        expect(item).to belong_to(:restaurant)
      end

      it 'has and belongs to many categories' do
        expect(item).to have_and_belong_to_many(:categories)
      end

      it 'has one attached picture' do
        expect(item).to have_one_attached(:item_picture)
      end
    end
  end

  describe '.active_storage_attachment' do
    context 'when attaching image' do
      it 'gets attached' do
        item.item_picture.attach(io: File.open('./app/assets/images/stock_img.jpeg'), filename: 'test-file.jpeg')
        expect(item.item_picture).to be_attached
      end
    end
  end
end
