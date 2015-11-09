class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:edit, :show, :update]
  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: 4
  end

  def destroy
    category = Category.find params[:id]
    category.destroy
    flash[:success] = t "message.delete_success"
    redirect_to admin_categories_path
  end

  def show
    @category = Category.find params[:id]
    @words = @category.words.order(created_at: :desc)
      .paginate page: params[:page], per_page: 4
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "message.update_success"
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "message.create_success"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t "message.invalid_input"
      render "new"
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find params[:id]
  end
end
