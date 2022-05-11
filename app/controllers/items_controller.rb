# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :find_restaurant, only: %i[show new create destroy edit]
  before_action :find_item, only: %i[show edit destroy]
  before_action :authorize_admin, only: %i[new edit create update destroy]

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = @restaurant.items.new(item_params)
    params[:item][:category_ids].each do |id|
      @item.categories << Category.find(id) if id.length.positive?
    end
    if @item.save
      @flash_msg = 'Item created successfully'
      redirect_to edit_restaurant_path(@restaurant)
    else
      @flash_msg = 'An error occured'
      render 'new'
    end
  end

  def destroy
    @item.destroy ? flash[:notice] = 'Item deleted successfully' : flash[:else] = 'An error occured'
    redirect_to edit_restaurant_path(@restaurant)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :retired)
  end

  def authorize_admin
    authorize :item, :admin_role
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def find_item
    @item = Item.includes(:restaurant).find(params[:id])
  end
end
