# frozen_string_literal: true

# Controller for admin
class AdminsController < ApplicationController
  before_action :authorize_admin, only: %i[index status_filter]

  def index
    authorize :admin
    @restaurants = Restaurant.restaurant_with_items
    @categories = Category.order(:id).all
    @orders = Order.all_orders
  end

  def status_filter
    @orders = if params[:status] == 'all'
                Order.all_orders
              else
                Order.with_status(params[:status])
              end
    respond_to do |format|
      format.js
    end
  end

  private

  def authorize_admin
    authorize :admin, :index?
  end
end
