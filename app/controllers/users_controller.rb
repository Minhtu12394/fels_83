class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :logged_in_user, except: [:new, :create]
  before_action :not_logged_in, only: [:new, :create]

  def index
    @users = User.activated.order(created_at: :desc)
      .paginate page: params[:page], per_page: 6
  end

  def new
    @user = User.new
  end

  def show
    @activities = @user.activities.order(created_at: :desc)
      .paginate page: params[:page], per_page: 9 if logged_in?
  end

  def create
    respond_to do |format|
      @user = User.new user_params
      if @user.save
        format.html{redirect_to root_url}
        format.json do
          render json: {message: t("message.signup_success")},
            status: :ok
        end
      else
        format.html do
          flash.now[:danger] = t "message.invalid_input"
          render "new"
        end
        format.json do
          render json: {message: t("message.invalid_input")},
            status: :unauthorized
        end
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "message.profile_updated"
      make_activity t(:update_profile)
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
