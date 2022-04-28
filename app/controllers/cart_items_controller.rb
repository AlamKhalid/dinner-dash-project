class CartItemsController < ApplicationController
  before_action :find_cart_item_and_cart, only: %i[update destroy]

  def update
    return if params[:quantity] == @cart_item.quantity

    if params[:commit] == '+'
      @cart_item.quantity += 1
      @cart.total_price += @cart_item.item.price
    elsif @cart_item.quantity != 1
      @cart_item.quantity -= 1
      @cart.total_price -= @cart_item.item.price
    end
    @cart_item.save
    @cart.save
  end

  def destroy
    @cart_item.destroy
    if CartItem.exists?(cart_order_id: @cart.id)
      @cart.total_price -= @cart_item.item.price * @cart_item.quantity
      @cart.save
    else
      @cart.destroy
    end
    redirect_to carts_path
  end

  private

  def find_cart_item_and_cart
    @cart_item = CartItem.find(params[:id])
    @cart = @cart_item.cart_order
  end
end
