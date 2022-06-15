# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create :category }

  describe '.creation' do
    context 'when valid' do
      it 'can be created' do
        expect(category).to be_valid
      end
    end

    context 'when invalid' do
      it 'cannot be created without name' do
        category.name = nil
        expect(category).not_to be_valid
        expect(category.errors).to include(:name)
      end
    end
  end

  describe '.uniqueness' do
    context 'when name is unique' do
      it 'is valid' do
        expect(category).to validate_uniqueness_of(:name)
      end
    end
  end

  describe '.association' do
    context 'with valid associations' do
      it 'has and belongs to many items' do
        expect(category).to have_and_belong_to_many(:items)
      end
    end
  end
end
