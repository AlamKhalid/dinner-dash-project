class AdminsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @categories = Category.all
    @orders = Order.all
  end
end
