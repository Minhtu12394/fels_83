class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: 4
  end

  def destroy
    category = Category.find params[:id]
    category.destroy
    flash[:success] = t :delete_success
    redirect_to admin_categories_path
  end
end
