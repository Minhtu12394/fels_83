class Admin::UsersController < ApplicationController
  def index
    @users = User.activated.paginate page: params[:page]
  end
end
