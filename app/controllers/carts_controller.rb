class CartsController < ApplicationController

  def index
    @cart = Cart.includes(:cart_order_items, :items).find_by(user_id: current_or_guest_user.id)
  end

  def update
  end

  def create
    @flash_msg = 'Item added to cart successfully'
    @class_alert = 'alert-success'
    @cart = Cart.find_by(user_id: current_or_guest_user.id)
    if @cart.nil?
      @cart = Cart.new
      @cart.user_id = current_or_guest_user.id
      @cart.restaurant_id = params[:restaurant_id]
      @cart.total_price += params[:quantity].to_i * Item.find(params[:item_id]).price
      @cart.save
      # create cart item
      @cart_item = CartItem.create(cart_order_id: @cart.id, item_id: params[:item_id], quantity: params[:quantity])
    elsif @cart.restaurant_id == params[:restaurant_id].to_i
      @cart_item = CartItem.find_by(cart_order_id: @cart.id, item_id: params[:item_id])
      if @cart_item.nil?
        @cart_item = CartItem.create(cart_order_id: @cart.id, item_id: params[:item_id], quantity: params[:quantity])
        @cart.total_price += params[:quantity].to_i * Item.find(params[:item_id]).price
      else
        old_qty = @cart_item.quantity
        item_price = Item.find(params[:item_id]).price
        @cart_item.quantity = params[:quantity].to_i
        @cart.total_price += (params[:quantity].to_i * item_price) - (old_qty * item_price)
        @cart_item.save
      end
      @cart.save
    else
      @flash_msg = 'Item from different restaurant already exists in cart'
      @class_alert = 'alert-danger'
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    Cart.find(params[:id]).destroy
    redirect_to carts_path
  end
end
