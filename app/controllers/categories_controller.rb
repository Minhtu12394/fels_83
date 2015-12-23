class CategoriesController < ApplicationController
  before_action :logged_in_user, unless: :json_request?
  before_action :verify_auth_token!, if: :json_request?

  def index
    respond_to do |format|
      @categories = Category.order(created_at: :desc)
        .paginate page: params[:page], per_page: 7
      format.html{}
      format.json{render json: @categories, status: :ok}
    end
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.start_by(current_user)
      .paginate page: params[:page], per_page: 7
  end
end
