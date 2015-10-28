class CategoriesController < ApplicationController
  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: 4
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
