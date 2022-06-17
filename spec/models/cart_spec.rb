# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryBot.create :cart }

  describe '.uniqueness' do
    context 'when user is unique' do
      it 'is valid' do
        expect(cart).to validate_uniqueness_of(:user_id)
      end
    end
  end
end
