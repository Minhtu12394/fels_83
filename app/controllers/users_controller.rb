class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create], unless: :json_request?
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :not_logged_in, only: [:new, :create]
  before_action :verify_auth_token!, except: [:new, :create], if: :json_request?

  def index
    if params[:q]
      @users = User.activated.search(params[:q]).order(created_at: :desc)
        .paginate page: params[:page], per_page: 6
      respond_to do |format|
        format.json {render json: @users, only: [:id, :name]}
      end
    else
      @users = User.activated.order(created_at: :desc)
        .paginate page: params[:page], per_page: 6
    end
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
      decode_avatar_data if json_request?
      @user = User.new user_params
      if @user.save
        make_activity t(:signup), nil, @user
        log_in @user
        make_activity t(:login)
        format.html{redirect_to root_url}
        format.json do
          render json: @user, status: :ok
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
      decode_avatar_data if json_request?
      if @user.update_attributes user_params
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
  def user_params
    params.require(:user).permit :name, :email, :avatar, :password,
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

  def decode_avatar_data
    return if params[:user][:avatar].nil?
    data = StringIO.new(Base64.decode64((params[:user][:avatar]).to_s))
    data.class.class_eval {attr_accessor :original_filename, :content_type}
    data.original_filename = "upload.png"
    data.content_type = "image/png"
    params[:user][:avatar] = data
  end
end
