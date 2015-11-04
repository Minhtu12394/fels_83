class Admin::UsersController < ApplicationController
  def index
    @users = User.activated.order(created_at: :desc)
      .paginate page: params[:page]
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    flash[:success] = t :delete_success
    redirect_to admin_users_path
  end
end
