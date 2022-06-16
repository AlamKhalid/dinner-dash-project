# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }
  let(:cart) { FactoryBot.create :cart, user: user, type: 'Cart' }
  let(:cart_item) { FactoryBot.create :cart_order_item, cart_order: cart, type: 'CartItem' }

  describe 'PUT update' do
    before { allow(controller).to receive(:current_user).and_return(user) }

    context 'when adding cart item' do
      it 'returns successful response' do
        put :update, xhr: true, params: { id: cart_item.id, button: 'add', quantity: 2, format: 'js' }
        cart_item.reload
        expect(response).to be_successful
        expect(assigns(:item_id)).to eq(cart_item.id)
      end

      it 'changes cart item attributes  ' do
        expect { put :update, params: { id: cart_item.id, button: 'add', quantity: 2, format: 'js' } }.to change {
                                                                                                            cart_item.reload.quantity
                                                                                                          }.by(1)
        expect { put :update, params: { id: cart_item.id, button: 'add', quantity: 2, format: 'js' } }.to change {
                                                                                                            cart.reload.total_price
                                                                                                          }.by(cart_item.item.price)
      end
    end

    context 'when subtracting cart item' do
      before { cart_item.quantity = 2 }

      it 'returns successful response' do
        put :update, xhr: true, params: { id: cart_item.id, button: 'remove', quantity: 1, format: 'js' }
        cart_item.reload
        expect(response).to be_successful
        expect(assigns(:item_id)).to eq(cart_item.id)
      end

      it 'changes cart item attributes' do
        expect { put :update, params: { id: cart_item.id, button: 'remove', quantity: 1, format: 'js' } }.to change {
                                                                                                               cart_item.reload.quantity
                                                                                                             }.by(1)
        expect { put :update, params: { id: cart_item.id, button: 'remove', quantity: 1, format: 'js' } }.to change {
                                                                                                               cart.reload.total_price
                                                                                                             }.by(cart_item.item.price)
      end
    end

    context 'when invalid params' do

    end
  end

  describe 'DELETE destroy' do
    before { allow(controller).to receive(:current_user).and_return(user) }

    context 'when cart is owned' do
      it 'can be deleted' do
        delete :destroy, params: { id: cart_item.id }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(carts_path)
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match('Cart item deleted successfully')
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
