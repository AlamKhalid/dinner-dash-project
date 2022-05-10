class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit]

  def index
    @orders = Order.includes(:restaurant, :cart_order_items).order(created_at: :desc)
    authorize @orders
  end

  def create
    @order = Order.new
    authorize @order
    cart = Cart.find_by(user_id: current_or_guest_user.id)
    cart.update(type: 'Order', status: 0)
    CartItem.where(cart_order_id: cart.id).update_all(type: 'OrderItem')
    redirect_to orders_path
  end

  def edit
  end

  def show
  end

  private

  def find_order
    @order = Order.includes(:restaurant, :cart_order_items).find(params[:id])
  end

end
