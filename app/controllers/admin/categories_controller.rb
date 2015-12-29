class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:edit, :show, :update]
  before_action :admin_user

  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: 4
  end

  def destroy
    category = Category.find params[:id]
    category.destroy
    flash[:success] = t "message.delete_success"
    make_activity t(:delete_category), category
    redirect_to admin_categories_path
  end

  def show
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
      make_activity t(:update_category), @category
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "message.create_success"
      make_activity t(:create_category), @category
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t "message.invalid_input"
      render "new"
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description, :photo
  end

  def load_category
    @category = Category.find params[:id]
  end
end
