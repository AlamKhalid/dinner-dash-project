# frozen_string_literal: true

# Controller for orders
class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit update]

  def index
    @orders = Order.includes(:restaurant, :cart_order_items).order(created_at: :desc).where(user_id: current_user.id)
    authorize @orders
  end

  def create
    @order = Order.new
    authorize @order
    cart = Cart.find_by(user_id: current_or_guest_user.id)
    cart.update(type: 'Order', status: 0)
    CartItem.where(cart_order_id: cart.id).update(type: 'OrderItem')
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

  def find_order
    @order = Order.includes(:restaurant, :cart_order_items).find(params[:id])
    authorize @order
  end
end
