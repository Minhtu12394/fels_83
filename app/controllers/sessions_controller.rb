class SessionsController < ApplicationController
  before_action :not_logged_in, only: [:new, :create]

  def new
  end

  def create
    respond_to do |format|
      user = User.find_by email: session_params[:email].downcase

      if user && user.authenticate(session_params[:password])
        log_in user
        session_params[:remember_me] == "1" ? remember(user) : forget(user)

        format.html{redirect_to home_path}
        format.json do
          render json: {user: user, message: t(:login_success)}, status: :ok
        end
      else
        format.html do
          flash.now[:danger] = t "message.invalid_login"
          render :new
        end
        format.json do
          render json: {message: t(:login_failed)}, status: :unauthorized
        end
      end
    end
  end

  def destroy
    make_activity t(:logout)
    log_out if logged_in?
    redirect_to root_url
  end

  def session_params
    params.require(:session).permit :email, :password, :remember_me
  end
end
