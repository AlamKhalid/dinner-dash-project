# frozen_string_literal: true

# Controller for items
class ItemsController < ApplicationController
  before_action :find_restaurant, only: %i[show new create edit update]
  before_action :find_item, only: %i[show edit update]
  before_action :authorize_admin, only: %i[new edit create update]

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to edit_restaurant_path(@restaurant)
    else
      flash.now[:alert] = 'An error occured'
      render 'edit'
    end
  end

  def create
    @item = @restaurant.items.new(item_params)
    save_item_check
  end

  private

  def save_item_check
    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to edit_restaurant_path(@restaurant)
    else
      flash.now[:notice] = 'An error occured'
      render 'new'
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :retired, :item_picture, category_ids: [])
  end

  def authorize_admin
    authorize :item, :admin_role?
  end

  def find_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id]) or not_found
  end

  def find_item
    @item = Item.includes(:restaurant).find_by(id: params[:id]) or not_found
  end
end
