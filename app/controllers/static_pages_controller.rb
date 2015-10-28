class StaticPagesController < ApplicationController
  def home
    @activities = Activity.feed_activities_by(current_user.id).order(created_at: :desc)
      .paginate page: params[:page], per_page: 6 if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
