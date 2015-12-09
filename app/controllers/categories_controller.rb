class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    respond_to do |format|
      @categories = Category.order(created_at: :desc)
        .paginate page: params[:page], per_page: 7
      format.json{render json: {categories: @categories}, status: :ok}
    end
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.start_by(current_user)
      .paginate page: params[:page], per_page: 7
  end
end
