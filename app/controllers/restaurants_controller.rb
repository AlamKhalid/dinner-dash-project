class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[update show edit destroy]
  before_action :new_restaurant_authorize, only: %i[new create]

  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    if @restaurant
      flash[:notice] = 'Created Restaurant successfully'
      redirect_to '/admins/index'
    else
      flash.now[:alert] = 'An error occured'
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      flash.now[:notice] = 'Updated Restaurant successfully'
    else
      flash.now[:alert] = 'An error occured'
    end
    respond_to do |format|
      format.js
    end
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

  def destroy
    @restaurant.destroy
    redirect_to '/admins/index'
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :location)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def new_restaurant_authorize
    @restaurant = Restaurant.new
    authorize @restaurant
  end
end
