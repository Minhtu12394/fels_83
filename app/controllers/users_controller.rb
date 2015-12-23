class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create], unless: :json_request?
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :not_logged_in, only: [:new, :create]
  before_action :verify_auth_token!, except: [:new, :create], if: :json_request?

  def index
    @users = User.activated.order(created_at: :desc)
      .paginate page: params[:page], per_page: 6
  end

  def new
    @user = User.new
  end

  def show
    respond_to do |format|
      @activities = @user.activities.order(created_at: :desc)
        .paginate page: params[:page], per_page: 9 if logged_in?
      format.html
      format.json do
        render json: @user, status: :ok
      end
    end
  end

  def create
    respond_to do |format|
      @user = User.new user_params
      if @user.save
        make_activity t(:signup), nil, @user

        format.html{redirect_to root_url}
        format.json do
          render json: {message: t("message.signup_success")},
            status: :ok
        end
      else
        format.html do
          render "new"
        end
        format.json do
          render json: {message: @user.errors},
            status: :unauthorized
        end
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes update_params
        success_message = t "message.profile_updated"
        make_activity t(:update_profile)

        format.html do
          flash[:success] = success_message
          redirect_to @user
        end
        format.json do
          render json: @user, status: :ok
        end
      else
        failed_message = t "message.update_failed"
        format.html do
          flash.now[:danger] = failed_message
          render "edit"
        end
        format.json do
          render json: {message: failed_message}, status: :bad_request
        end
      end
    end
  end

  private
  def update_params
    params.require(:user).permit :name, :password, :avatar,
      :password_confirmation
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find params[:id] if params[:id]
  end

  def correct_user
    @user = User.find params[:id]
    unless current_user? @user
      respond_to do |format|
        format.html{redirect_to(root_url)}
        format.json do
          render json: {message: t(:cant_edit_other_user)},
            status: :bad_request
        end
      end
    end
  end
end
