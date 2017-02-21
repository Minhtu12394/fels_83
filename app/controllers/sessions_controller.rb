class SessionsController < ApplicationController
  before_action :not_logged_in, only: [:new, :create], unless: :json_request?
  before_action :verify_session_params!, only: :create

  def new
  end

  def create
    respond_to do |format|
      user = User.find_by email: session_params[:email].downcase

      if user && user.authenticate(session_params[:password])
        log_in user
        session_params[:remember_me] == "1" ? remember(user) : forget(user)
        make_activity t(:login)

        format.html{redirect_to home_path}
        format.json do
          render json: user, status: :ok
        end
      else
        format.html do
          flash.now[:danger] = t "message.invalid_login"
          render :new
        end
        format.json do
          render json: {message: t("message.invalid_login")},
            status: :unauthorized
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if logged_in?
        make_activity t(:logout)
        log_out
      end
      format.html{redirect_to root_url}
      format.json{render json: {message: t(:logout_success)}, status: :ok}
    end
  end

  private
  def session_params
    params.require(:session).permit :email, :password, :remember_me
  end

  def verify_session_params!
    if params[:session].blank?
      render json: {message: "Session params is missing or wrong"}, status: :bad_request
    end
  end
end
