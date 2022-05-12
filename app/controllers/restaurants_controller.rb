# frozen_string_literal: true

# Controller for restaurants
class RestaurantsController < ApplicationController
  before_action :authorize_admin, only: %i[new edit create update]
  before_action :find_restaurant, only: %i[update show edit]

  def index
    @restaurants = Restaurant.all
  end

  def new; end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    if @restaurant
      flash[:notice] = 'Created Restaurant successfully'
      redirect_to admins_index_path
    else
      flash.now[:alert] = 'An error occured'
      render :new
    end
  end

  def edit; end

  def update
    if @restaurant.update(restaurant_params)
      @flash_msg = 'Updated Restaurant successfully'
      @class_alert = 'alert-success'
    else
      @flash_msg = 'An error occured'
      @class_alert = 'alert-danger'
    end
    respond_to do |format|
      format.js
    end
  end

  def category_filter
    @restaurant = Restaurant.find(params[:restaurant_id])
    filtered_items_by_category
    respond_to do |format|
      format.js
    end
  end

  def show; end

  private

  def filtered_items_by_category
    case params[:category_name]
    when 'all'
      @items = @restaurant.items
    when 'popular'
      # find one with most order count
      popular_items
    else
      @items = Item.restaurant_items(params[:restaurant_id]).filter_category(params[:category_name])
    end
  end

  def authorize_admin
    authorize :restaurant, :admin_role?
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :location)
  end

  def popular_items
    item_id = Item.restaurant_items(params[:restaurant_id]).order_items.group(:id).count.max_by { |_k, v| v }.first
    @items = []
    @items << Item.find(item_id)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
