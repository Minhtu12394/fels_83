class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.activated.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "message.please_activate_account"
      redirect_to root_url
    else
      flash.now[:danger] = t "message.invalid_input"
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "message.profile_updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find params[:id] if params[:id]
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to(root_url) unless current_user? @user
  end
end
