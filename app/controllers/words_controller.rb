class WordsController < ApplicationController
  def index
    @words = Word.paginate page: params[:page], per_page: 7
  end
end
