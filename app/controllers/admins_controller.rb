# frozen_string_literal: true

# Controller for admin
class AdminsController < ApplicationController
  before_action :authorize_admin, only: %i[index status_filter]

  def index
    authorize :admin
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

  private

  def authorize_admin
    authorize :admin, :index?
  end
end
