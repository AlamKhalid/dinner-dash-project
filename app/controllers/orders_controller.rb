# frozen_string_literal: true

# Controller for orders
class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit update]

  def index
    authorize Order
    @orders = Order.for_user(current_user.id)
  end

  def create
    @order = Order.new
    authorize @order
    @cart = current_or_guest_user.cart
    return if cart_has_retired_item

    @cart.update(type: 'Order', status: 0)
    CartItem.where(cart_order_id: @cart.id).update(type: 'OrderItem')
    flash[:notice] = 'Order placed successfully'
    redirect_to orders_path
  end

  def edit; end

  def show; end

  def update
    if @order.update(status: params[:status].to_i)
      flash[:notice] = 'Order status updated successfully'
      redirect_to admins_index_path
    else
      flash[:alert] = 'An error occured'
      render 'edit'
    end
  end

  private

  def cart_has_retired_item
    return unless @cart.items.where(retired: true).exists?

    flash[:alert] = 'Cart contains a retired item. Please clear cart and start a new one'
    redirect_to carts_path
    true
  end

  def find_order
    @order = Order.includes(:restaurant, :cart_order_items).find(params[:id])
    authorize @order
  end
end
