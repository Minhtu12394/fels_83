class CategoriesController < ApplicationController
  before_action :logged_in_user, unless: :json_request?
  before_action :verify_auth_token!, if: :json_request?

  def index
    respond_to do |format|
      @categories = Category.order(created_at: :desc)
        .paginate page: params[:page], per_page: (params[:per_page] || 10)
      format.html{}
      format.json do
        render json: @categories,
          meta: @categories.total_pages,
          meta_key: "total_pages",
          status: :ok
      end
    end
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.start_by(current_user)
      .paginate page: params[:page], per_page: 7
  end
end
