class FollowingsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @users = @user.following.paginate page: params[:page], per_page: 6
  end
end
