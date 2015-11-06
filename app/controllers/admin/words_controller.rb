class Admin::WordsController < ApplicationController
  def new
    category = Category.find params[:category_id]
    @word = category.words.build
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "message.create_success"
      redirect_to [:admin, @word.category]
    else
      flash.now[:danger] = t "message.invalid_input"
      render "new"
    end
  end

  def edit
    @word = Word.find params[:id]
  end

  def update
    @word = Word.find params[:id]
    if @word.update_attributes word_params
      flash[:success] = t "message.update_success"
      redirect_to [:admin, @word.category]
    else
      render "edit"
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
