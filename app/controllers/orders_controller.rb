class OrdersController < ApplicationController
  def index
    @orders = Order.all
    authorize @orders
  end
end
