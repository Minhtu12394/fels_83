class Admin::LessonsController < ApplicationController
  include LessonsHelper

  def index
    @lessons = Lesson.order(created_at: :desc)
    .paginate page: params[:page]
  end

  def destroy
    lesson = Lesson.find params[:id]
    lesson.destroy
    flash[:success] = t "message.delete_success"
    redirect_to admin_lessons_path
  end
end
