class RelationshipsController < ApplicationController
  before_action :logged_in_user, unless: :json_request?
  before_action :verify_auth_token!, if: :json_request?

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
      unless current_user.following?(@user)
        current_user.follow @user
        make_activity t(:follow), @user
      end
      format.js
      format.json{render json: {message: t(:follow_success)}, status: :ok}
    end
  end

  def destroy
    respond_to do |format|
      relationship = Relationship.find_by(id: params[:id])
      if relationship
        @user = relationship.followed
        current_user.unfollow @user
        make_activity t(:unfollow), @user
      end
      format.js
      format.json{render json: {message: t(:unfollow_success)}, status: :ok}
    end
  end
end
