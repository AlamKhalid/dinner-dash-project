# frozen_string_literal: true

# Controller for restaurants
class RestaurantsController < ApplicationController
  before_action { ActiveStorage::Current.host = request.base_url }

  before_action :authorize_admin, only: %i[new edit create update]
  before_action :find_restaurant, only: %i[update show edit]

  skip_before_action :verify_authenticity_token, only: %i[category_filter]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = 'Created Restaurant successfully'
      redirect_to admins_index_path
    else
      flash.now[:alert] = 'An error occured'
      render 'new'
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
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    return if @restaurant.nil?

    filter_items_by_category
    respond_to do |format|
      format.js
      format.json { render json: @items }
    end
  end

  def show
    @items = @restaurant&.items&.where(retired: false)
    respond_to do |format|
      format.html
      format.json { render json: { restaurant: @restaurant, items: @items, include: [:item_picture] } }
    end
  end

  private

  def filter_items_by_category
    case params[:category_name]
    when 'all'
      @items = @restaurant.items.not_retired
    when 'popular'
      # find one with most order count
      popular_items
    else
      @items = Item.restaurant_items(params[:restaurant_id]).not_retired.filter_category(params[:category_name])
    end
  end

  def authorize_admin
    authorize :restaurant, :admin_role?
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :location)
  end

  def popular_items
    item_id = Item.restaurant_items(params[:restaurant_id]).order_items.group(:id).count.max_by { |_k, v| v }&.first
    @items = []
    item = Item.find_by(id: item_id)
    return if item.nil?

    @items << item
  end

  def find_restaurant
    @restaurant = Restaurant.find_by(id: params[:id]) or render_not_found_template
  end
end
