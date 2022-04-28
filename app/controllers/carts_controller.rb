class CartsController < ApplicationController
  def index
    @cart = Cart.includes(:cart_order_items, :items).find_by(user_id: current_user.id)
  end

  def update
  end

  def create
    @cart = Cart.find_or_create_by(user_id: current_user.id)
    @cart_item = CartItem.create(cart_order_id: @cart.id, item_id: params[:item_id], quantity: params[:quantity])
    @cart.total_price += params[:quantity].to_i * Item.find(params[:item_id]).price
    @cart.save
    respond_to do |format|
      format.js
    end
    flash.now[:notice] = 'Item added to cart successfully'
  end

  def destroy
    Cart.find(params[:id]).destroy
    redirect_to carts_path
  end
end
