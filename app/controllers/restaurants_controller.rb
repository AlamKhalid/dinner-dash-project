class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[update show edit]

  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def edit
  end

  def category_filter
    @restaurant = Restaurant.find(params[:restaurant_id])
    case params[:category_name]
    when 'all'
      @items = @restaurant.items
    when 'popular'
      # find one with most order count
      item_id = Item.includes(:cart_order_items).where(restaurant_id: params[:restaurant_id]).where(cart_order_items:
                { type: 'OrderItem' }).group(:id).count.max_by{ |k,v| v }.first
      @items = []
      @items << Item.find(item_id)
    else
      @items = Item.includes(:categories).where(restaurant_id: params[:restaurant_id])
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
