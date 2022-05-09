class AdminsController < ApplicationController
  def index
    authorize :admin, :index?
    @restaurants = Restaurant.includes(:items).order(:id).all
    @categories = Category.order(:id).all
    @orders = Order.all

  end
end
