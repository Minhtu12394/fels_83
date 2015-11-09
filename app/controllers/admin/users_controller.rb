class Admin::UsersController < ApplicationController
  def index
    @users = User.activated.order(created_at: :desc)
      .paginate page: params[:page]
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    flash[:success] = t "message.delete_success"
    make_activity t(:destroy_user), user
    redirect_to admin_users_path
  end
end
