# frozen_string_literal: true

# Controller for category
class CategoriesController < ApplicationController
  before_action :authorize_admin, except: :index
  before_action :find_category, only: %i[edit update destroy]

  def index
    @categories = Category.pluck(:name)
    respond_to do |format|
      format.json { render json: @categories }
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created successfully'
      redirect_to admins_index_path
    else
      flash.now[:alert] = 'An error occured'
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category updated successfully'
      redirect_to admins_index_path
    else
      flash.now[:alert] = 'An error occured'
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category deleted successfully'
    else
      flash[:alert] = 'An error occured'
    end
    redirect_to admins_index_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def authorize_admin
    authorize :category, :admin_role?
  end

  def find_category
    @category = Category.find_by(id: params[:id]) or render_not_found_template
  end
end
