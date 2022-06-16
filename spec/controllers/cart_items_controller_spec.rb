# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }
  let(:cart_item) { FactoryBot.create :cart_order_item, type: 'CartItem' }

  describe 'PUT update' do

  end

  describe 'DELETE destroy' do
    before { allow(controller).to receive(:current_user).and_return(user) }

    context 'when cart is owned' do
      it 'can be deleted' do
        delete :destroy, params: { id: cart_item.id }
        expect(response).to be_successful
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the cart item in database' do
        expect { delete :destroy, params: { id: cart_item.id } }.to change(CartItem, :count).by(1)
      end
    end

    context 'when cart item id is invalid' do
      it 'returns 404 status code' do
        delete :destroy, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when cart is not owned' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns from function' do
        delete :destroy, params: { id: cart_item.id }
        expect(response).to be_successful
      end
    end
  end
end
