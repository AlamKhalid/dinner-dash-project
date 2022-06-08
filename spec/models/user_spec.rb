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

  context 'when password is short' do
    it 'cannot be created' do
      user.password = '123'
      expect(user).to be_invalid
    end
  end
end
