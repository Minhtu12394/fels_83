class WordsController < ApplicationController
  def index
    @words = Word.order(created_at: :desc)
      .paginate page: params[:page], per_page: 7
  end
end
