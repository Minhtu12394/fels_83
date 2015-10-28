class LessonsController < ApplicationController

  before_action :load_category, only: [:create]
  before_action :load_lesson, only: [:update, :show]

  def show
  end

  def create
    @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
    if @lesson.save
      flash[:success] = t "message.create_success"
      redirect_to @lesson
    else
      flash[:danger] = t "message.create_failed"
      redirect_to @category
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = "message.update_success"
    else
      flash[:danger] = t "message.update_failed"
    end
    redirect_to @lesson
  end

  private
  def lesson_params
    params.require(:lesson).permit :learned, results_attributes: [:id, :answer_id]
  end
  def load_category
    @category = Category.find params[:category_id]
  end

  def load_lesson
    @lesson = Lesson.find params[:id]
  end
end
