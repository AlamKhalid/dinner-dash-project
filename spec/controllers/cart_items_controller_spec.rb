# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }
  let(:cart) { FactoryBot.create :cart, user: user, type: 'Cart' }
  let(:cart_item) { FactoryBot.create :cart_order_item, cart_order: cart, type: 'CartItem' }
  let(:item) { FactoryBot.create :item2, name: 'Item2' }
  let(:cart_item_dup) { FactoryBot.create :cart_order_item, cart_order: cart, type: 'CartItem', item: item }
  let(:valid_params) do
    {
      id: cart_item.id,
      button: 'add',
      quantity: 2,
      format: 'js'
    }
  end

  describe '#PUT update' do
    before { allow(controller).to receive(:current_user).and_return(user) }

    context 'when adding cart item' do
      it 'returns successful response with modified attributes' do
        put :update, xhr: true, params: valid_params
        old_qty = cart_item.quantity
        old_price = cart.total_price
        cart_item.reload
        cart.reload
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:item_id)).to eq(cart_item.id)
        expect(old_qty).not_to eq(cart_item.quantity)
        expect(old_price).not_to eq(cart.total_price)
      end
    end

    context 'when subtracting cart item' do
      before do
        cart_item.quantity = 2
        cart.total_price = 400
        cart_item.save
        cart.save
        valid_params[:quantity] = 1
        valid_params[:button] = 'remove'
      end

      it 'returns successful response with updated attributes' do
        put :update, xhr: true, params: valid_params
        old_qty = cart_item.quantity
        old_price = cart.total_price
        cart_item.reload
        cart.reload
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:item_id)).to eq(cart_item.id)
        expect(old_qty).not_to eq(cart_item.quantity)
        expect(old_price).not_to eq(cart.total_price)
      end
    end

    context 'when invalid params' do
      it 'returns if quantity are equal' do
        valid_params[:quantity] = 1
        put :update, xhr: true, params: valid_params
        old_qty = cart_item.quantity
        old_price = cart.total_price
        cart_item.reload
        cart.reload
        expect(response).to be_successful
        expect(assigns(:item_id)).to eq(nil)
        expect(old_qty).to eq(cart_item.quantity)
        expect(old_price).to eq(cart.total_price)
      end

      it 'does not do anything if button action is not defined' do
        valid_params[:button] = ''
        put :update, xhr: true, params: { id: cart_item.id, button: '', quantity: 2, format: 'js' }
        old_qty = cart_item.quantity
        old_price = cart.total_price
        cart_item.reload
        cart.reload
        expect(response).to be_successful
        expect(assigns(:item_id)).to eq(cart_item.id)
        expect(old_qty).to eq(cart_item.quantity)
        expect(old_price).to eq(cart.total_price)
      end
    end

    context 'when cart is not owned' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns from the action' do
        put :update, xhr: true, params: valid_params
        old_qty = cart_item.quantity
        old_price = cart.total_price
        cart_item.reload
        cart.reload
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(assigns(:item_id)).to eq(nil)
        expect(old_qty).to eq(cart_item.quantity)
        expect(old_price).to eq(cart.total_price)
      end
    end
  end

  describe '#DELETE destroy' do
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

    context 'when more then one cart item are there' do
      before do
        cart_item.cart_order = cart
        cart_item_dup.cart_order = cart
        cart.total_price = 400
        cart_item.save
        cart_item_dup.save
        cart.save
      end

      it 'does not delete cart' do
        old_count = cart.cart_order_items.count
        delete :destroy, params: { id: cart_item.id }
        old_price = cart.total_price
        cart.reload
        expect(cart.cart_order_items.count).not_to eq(old_count)
        expect(cart.cart_order_items.count).to eq(1)
        expect(cart.total_price).not_to eq(old_price)
        expect(cart_item_dup.reload).not_to eq(nil)
        expect { cart_item.reload }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when cart item id is invalid' do
      it 'returns 404 status code' do
        delete :destroy, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(response.status).to eq(404)
      end
    end

    context 'when cart is not owned' do
      before { allow(controller).to receive(:current_user).and_return(admin) }

      it 'returns from function' do
        delete :destroy, params: { id: cart_item.id }
        expect(response).to be_successful
        expect(response).to have_http_status(:no_content)
        expect(response.status).to eq(204)
      end
    end
  end
end
