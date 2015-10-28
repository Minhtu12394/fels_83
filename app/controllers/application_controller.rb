class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "message.please_login"
      redirect_to login_path
    end
  end

  def make_activity behavior, object = nil, user = current_user
    Activity.create! behavior: behavior,
        object: object.nil? ? nil : object.base_resource, user_id: user.id
  end
end
