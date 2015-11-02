class FollowersController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @users = @user.followers.paginate page: params[:page], per_page: 6
  end
end
