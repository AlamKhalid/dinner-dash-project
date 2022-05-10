# frozen_string_literal: true

class AdminsController < ApplicationController
  def index
    authorize :admin, :index?
    @restaurants = Restaurant.includes(:items).order(:id).all
    @categories = Category.order(:id).all
    @orders = Order.includes(:user, :restaurant).order(:id).all
  end

  def status_filter
    @orders = if params[:status] == '-1'
                Order.includes(:user,
                               :restaurant).order(:id).all
              else
                Order.includes(:user,
                               :restaurant).order(:id).where(status: params[:status]).all
              end
    respond_to do |format|
      format.js
    end
  end
end
