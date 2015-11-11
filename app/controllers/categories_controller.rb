class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: 7
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.start_by(current_user)
      .paginate page: params[:page], per_page: 7
  end
end
