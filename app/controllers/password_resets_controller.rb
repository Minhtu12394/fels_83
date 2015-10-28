class PasswordResetsController < ApplicationController
  before_action :verify_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email]
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "message.email_have_send"
      redirect_to root_url
    else
      flash.now[:danger] = t "message.email_not_found"
      render "new"
    end
  end

  def edit
    @user = User.find_by email: params[:email]
    log_in @user
  end

  def update
    if params[:user][:password].empty?
      current_user.errors.add :password, t("message.cant_be_empty")
      render "edit"
    elsif current_user.update_attributes user_params
      flash[:success] = t "message.password_has_been_reset"
      redirect_to current_user
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def verify_user
    unless @user && @user.activated? &&
      @user.authenticated? :reset, params[:id]
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "message.password_reset_has_expired"
      redirect_to new_password_reset_url
    end
  end
end
