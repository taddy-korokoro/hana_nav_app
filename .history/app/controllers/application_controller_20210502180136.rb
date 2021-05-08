class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ログイン済ユーザーのみにアクセスを許可する
    # before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :login_required

  def login_required
    if already_logged_in? # ログインしてなければの条件分岐
      redirect_to root_path
    else
      redirect_to spots_path
    end
  end

  # def after_sign_in_path_for(resource)
  #   spots_path(resource)
  # end

  protected

    def configure_permitted_parameters
      added_attrs = [ :user_name, :self_introduction ]
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :user_name ])
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
end
