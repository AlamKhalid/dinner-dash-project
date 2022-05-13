# frozen_string_literal: true

# Controller for cart item
class CartItemsController < ApplicationController
  before_action :find_cart_item_and_cart, only: %i[update destroy]

  def update
    return if params[:quantity] == @cart_item.quantity || @cart.user_id != current_or_guest_user.id

    if params[:commit] == '+'
      adding_cart_action
    elsif @cart_item.quantity != 1
      removing_cart_action
    end
    save_cart_and_cart_item

    respond_to do |format|
      format.js
    end
  end

  def destroy
    return if @cart.user_id != current_or_guest_user.id

    if @cart_item.destroy
      check_exisiting_cart
      flash[:notice] = 'Cart item deleted successfully'
    else
      flash[:alert] = 'An error occured'
    end
    redirect_to carts_path
  end

  private

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
  end

  def find_cart_item_and_cart
    @cart_item = CartItem.find(params[:id])
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
end
