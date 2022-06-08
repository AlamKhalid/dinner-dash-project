# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build :user }

  describe '.creation' do
    context 'when valid' do
      it 'can be created' do
        expect(user).to be_valid
      end
    end

    context 'when invalid' do
      it 'cannot be created without full name' do
        user.full_name = nil
        expect(user).not_to be_valid
      end

      it 'cannot be created without email' do
        user.email = nil
        expect(user).not_to be_valid
      end

      it 'cannot be created without password' do
        user.password = nil
        expect(user).not_to be_valid
      end
    end
  end

  describe '.validations' do
    context 'when password is short' do
      it 'cannot be created' do
        user.password = '123'
        expect(user).to be_invalid
      end
    end

    context 'when display name is present' do
      it 'is valid is length is more than 2' do
        user.display_name = 'Alam'
        expect(user).to be_valid
      end

      it 'is valid is length is 1' do
        user.display_name = 'a'
        expect(user).to be_invalid
      end
    end
  end

  describe '.association' do
    context 'with valid associations' do
      it 'has many orders' do
        expect(user).to have_many(:orders)
      end

      it 'has one cart' do
        expect(user).to have_one(:cart)
      end
    end
  end

  describe '.uniqueness' do
    context 'when email is unique' do
      it 'is valid' do
        expect(user).to validate_uniqueness_of(:email).case_insensitive
      end
    end
  end
end
