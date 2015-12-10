class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?

  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      respond_to do |format|
        store_location
        message_please_login = t "message.please_login"
        format.html do
          flash[:danger] = message_please_login
          redirect_to login_path
        end
        format.json do
          render json: {message: message_please_login}, status: :unauthorized
        end
      end
    end
  end

  def make_activity behavior, object = nil, user = current_user
    Activity.create! behavior: behavior,
      object: object.nil? ? nil : object.base_resource, user_id: user.id
  end

  def admin_user
    unless logged_in? && current_user.admin?
      flash[:danger] = t "message.you_not_be_admin"
      redirect_to root_path
    end
  end

  def not_logged_in
    if logged_in?
      respond_to do |format|
        format.html do
          flash[:danger] = t "message.please_logout"
          redirect_to root_path
        end
        format.json do
          render json: {message: t("please_logout")}, status: :bad_request
        end
      end
    end
  end

  def json_request?
    request.format.json?
  end
end
