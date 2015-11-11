class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.activated.order(created_at: :desc)
      .paginate page: params[:page], per_page: 6
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    flash[:success] = t "message.delete_success"
    make_activity t(:destroy_user), user
    redirect_to admin_users_path
  end
end
