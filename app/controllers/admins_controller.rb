class AdminsController < ApplicationController
  def index
    authorize :admin, :index?
    @restaurants = Restaurant.includes(:items).all
    @categories = Category.all
    @orders = Order.all

  end
end
