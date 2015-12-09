class LessonsController < ApplicationController
  include LessonsHelper
  before_action :logged_in_user
  before_action :load_category, only: [:create]
  before_action :load_lesson, only: [:update, :show, :destroy]

  def show
  end

  def create
    respond_to do |format|
      @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
      if @lesson.save
        success_message = t "message.create_success"
        format.html do
          flash[:success] = success_message
          redirect_to @lesson
        end
        format.json do
          render json: {lesson: @lesson, message: success_message}, status: :ok
        end
      else
        failed_message = t "message.create_failed"
        format.html do
          flash[:danger] = failed_message
          redirect_to @category
        end
        format.json do
          render json: {message: failed_message}, status: :bad_request
        end
      end
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "message.update_success"

      make_activity t(:finish_lesson), @lesson
    else
      flash[:danger] = t "message.update_failed"
    end
    redirect_to @lesson
  end

  def destroy
    @lesson.destroy
    flash[:success] = t "message.delete_success"

    make_activity t(:destroy_lesson), @lesson
    redirect_to @lesson.category
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
