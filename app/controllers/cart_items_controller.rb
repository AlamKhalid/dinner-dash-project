# frozen_string_literal: true

# Controller for cart item
class CartItemsController < ApplicationController
  before_action :find_cart_item_and_cart, only: %i[update destroy]

  skip_before_action :verify_authenticity_token, only: %i[update destroy]

  def update
    return if params[:quantity] == @cart_item.quantity || check_params_user_id

    if params[:button] == 'add'
      adding_cart_action
    elsif remove_button_invoked
      removing_cart_action
    end
    save_cart_and_cart_item

    respond_to do |format|
      format.js
      format.json { render json: @cart, include: %i[cart_order_items items] }
    end
  end

  def destroy
    return if check_params_user_id

    if @cart_item.destroy
      destroy_success
    else
      destroy_fail
    end
    respond_to do |format|
      format.html { redirect_to carts_path }
      format.json { render json: @payload }
    end
  end

  private

  def destroy_success
    check_exisiting_cart
    msg = 'Cart item deleted successfully'
    flash[:notice] = msg
    @payload = { message: msg }
  end

  def destroy_fail
    msg = 'Could not delete cart item'
    flash[:alert] = msg
    @payload = { error: msg, status: 422 }
  end

  def check_params_user_id
    @cart.user_id != (params[:user_id] || current_or_guest_user.id)
  end

  def check_exisiting_cart
    if CartItem.exists?(cart_order_id: @cart.id)
      @cart.total_price -= @cart_item.item.price * @cart_item.quantity
      @cart.save
    else
      @cart.destroy
    end
  end

  def save_cart_and_cart_item
    @cart_item.save
    @cart.save
    @item_id = params[:id].to_i
  end

  def find_cart_item_and_cart
    @cart_item = CartItem.find_by(id: params[:id]) or render_not_found_template
    return if @cart_item.nil?

    @cart = @cart_item.cart_order
  end

  def adding_cart_action
    @cart_item.quantity += 1
    @cart.total_price += @cart_item.item.price
  end

  def removing_cart_action
    @cart_item.quantity -= 1
    @cart.total_price -= @cart_item.item.price
  end

  def remove_button_invoked
    params[:button] == 'remove' && @cart_item.quantity != 1
  end
end
