# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create :order }

  describe '.enum' do
    context 'with status enum' do
      it 'is valid' do
        expect(order).to define_enum_for(:status).with_values(%i[ordered paid cancelled completed]).with_prefix(:status)
      end
    end
  end
end
