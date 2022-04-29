class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[update show]

  def index
    @restaurants = Restaurant.all
  end

  def update
    case params[:category_name]
    when 'all'
      @items = @restaurant.items
    when 'popular'
      # find one with most order count
    else
      @items = Item.includes(:categories).where(restaurant_id: params[:id])
                   .where(categories: { name: params[:category_name] })
    end
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
