# frozen_string_literal: true

# Controller for cart
class CartsController < ApplicationController
  before_action :find_cart, only: %i[destroy]

  skip_before_action :verify_authenticity_token, only: %i[create destroy]

  def index
    @cart = Cart.includes(:cart_order_items, :items).find_by(user_id: check_params_user_id)
    respond_to do |format|
      format.html
      format.json { render json: @cart, include: %i[cart_order_items items] }
    end
  end

  def create
    return if Item.find_by(id: params[:item_id])&.retired

    success_flash
    @cart = Cart.find_by(user_id: check_params_user_id)
    cart_create_action
    @item_count = @cart.cart_order_items.count
    respond_to do |format|
      format.js
      format.json { render json: { success: @success, item_count: @item_count } }
    end
  end

  def destroy
    return if @cart.nil?

    # || @cart.user_id != (params[:user_id] || current_or_guest_user.id)

    if @cart.destroy
      destroy_success
    else
      destory_fail
    end
    respond_to do |format|
      format.html { redirect_to carts_path }
      format.json { render json: @payload }
    end
  end

  private

  def destroy_success
    msg = 'Cart deleted successfully'
    flash[:notice] = msg
    @payload = { message: msg }
  end

  def destory_fail
    msg = 'An error occured'
    flash[:alert] = msg
    @payload = { message: msg }
  end

  def check_params_user_id
    params[:user_id] || current_or_guest_user.id
  end

  def cart_create_action
    if @cart.nil?
      create_new_cart
    elsif @cart.restaurant_id == params[:restaurant_id].to_i && @cart.user_id == check_params_user_id
      create_or_update_cart_item
    else
      error_flash
    end
  end

  def error_flash
    @flash_msg = 'Item from different restaurant already exists in cart'
    @class_alert = 'alert-danger'
    @success = false
  end

  def success_flash
    @flash_msg = 'Item added to cart successfully'
    @class_alert = 'alert-success'
    @success = true
  end

  def create_new_cart
    cart_creation
    @cart.save
    # create cart item
    @cart_item = CartItem.create(cart_order_id: @cart.id, item_id: params[:item_id], quantity: params[:quantity])
  end

  def cart_creation
    @cart = Cart.new
    @cart.user_id = check_params_user_id
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
    @cart = Cart.find_by(id: params[:id]) or render_not_found_template
  end
end
