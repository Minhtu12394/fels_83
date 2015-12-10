class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find params[:user_id]
    @title = params[:relationship_type]
    if ["following", "followers"].include? params[:relationship_type]
      @users = @user.send(params[:relationship_type])
        .paginate page: params[:page], per_page: 6
    else
      redirect_to root_url
    end
  end
  def create
    respond_to do |format|
      @user = User.find params[:followed_id]
      current_user.follow @user
      make_activity t(:follow), @user
      format.js
      format.json{render json: {message: t(:follow_success)}, status: :ok}
    end
  end

  def destroy
    respond_to do |format|
      @user = Relationship.find(params[:id]).followed
      current_user.unfollow @user
      make_activity t(:unfollow), @user
      format.js
      format.json{render json: {message: t(:unfollow_success)}, status: :ok}
    end
  end
end
