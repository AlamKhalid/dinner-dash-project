# frozen_string_literal: true

# Controller for cart
class CartsController < ApplicationController
  before_action :find_cart, only: %i[destroy]

  def index
    @cart = Cart.includes(:cart_order_items, :items).find_by(user_id: current_or_guest_user.id)
  end

  def create
    return if Item.find_by(id: params[:item_id])&.retired

    success_flash
    @cart = Cart.find_by(user_id: current_or_guest_user.id)
    cart_create_action
    @item_count = @cart.cart_order_items.count
    respond_to do |format|
      format.js
    end
  end

  def destroy
    return if @cart.nil? || @cart.user_id != current_or_guest_user.id

    @cart.destroy ? flash[:notice] = 'Cart deleted successfully' : flash[:alert] = 'An error occured'
    redirect_to carts_path
  end

  private

  def cart_create_action
    if @cart.nil?
      create_new_cart
    elsif @cart.restaurant_id == params[:restaurant_id].to_i && @cart.user_id == current_or_guest_user.id
      create_or_update_cart_item
    else
      error_flash
    end
  end

  def error_flash
    @flash_msg = 'Item from different restaurant already exists in cart'
    @class_alert = 'alert-danger'
  end

  def success_flash
    @flash_msg = 'Item added to cart successfully'
    @class_alert = 'alert-success'
  end

  def create_new_cart
    cart_creation
    @cart.save
    # create cart item
    @cart_item = CartItem.create(cart_order_id: @cart.id, item_id: params[:item_id], quantity: params[:quantity])
  end

  def cart_creation
    @cart = Cart.new
    @cart.user_id = current_or_guest_user.id
    @cart.restaurant_id = params[:restaurant_id]
    @cart.total_price += params[:quantity].to_i * Item.find_by(id: params[:item_id])&.price
  end

  def create_or_update_cart_item
    @cart_item = CartItem.find_by(cart_order_id: @cart.id, item_id: params[:item_id])
    if @cart_item.nil?
      create_new_cart_item
    else
      update_old_cart_item
      @cart_item.save
    end
    @cart.save
  end

  def create_new_cart_item
    @cart_item = CartItem.create(cart_order_id: @cart.id, item_id: params[:item_id], quantity: params[:quantity])
    @cart.total_price += params[:quantity].to_i * Item.find_by(id: params[:item_id])&.price
  end

  def update_old_cart_item
    old_qty = @cart_item.quantity
    item_price = Item.find_by(id: params[:item_id])&.price
    @cart_item.quantity = params[:quantity].to_i + old_qty
    @cart.total_price += (params[:quantity].to_i * item_price)
  end

  def find_cart
    @cart = Cart.find_by(params[:id])
  end
end
