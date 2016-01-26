class WordsController < ApplicationController
  before_action :logged_in_user, unless: :json_request?
  before_action :verify_auth_token!, if: :json_request?

  def index
    respond_to do |format|
      @categories = Category.all
      if !params[:category_id].nil? && params[:category_id].empty?
        @words = Word.send params[:option], current_user.id
      elsif category = @categories.find_by(id: params[:category_id])
        @words = category.words.send params[:option], current_user.id
      else
        @words = Word.all
      end
      @words = @words.paginate page: params[:page], per_page: 6
      format.html
      format.js
      format.json do
        render json: @words, status: :ok
      end
    end
  end
end
