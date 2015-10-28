class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: session_params[:email].downcase

    if user && user.authenticate(session_params[:password])
      if user.activated?
        log_in user
        session_params[:remember_me] == "1" ? remember(user) : forget(user)
      else
        message = t "message.account_not_active"
        message += t "message.check_account_to_active"
        flash[:warning] = message
      end
      redirect_to home_path
    else
      flash.now[:danger] = t "message.invalid_login"
      render "new"
    end
  end

  def session_params
    params.require(:session).permit :email, :password, :remember_me
  end
end
