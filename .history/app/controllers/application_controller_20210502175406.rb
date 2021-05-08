class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ログイン済ユーザーのみにアクセスを許可する
    # before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :login_required

  # def after_sign_in_path_for(resource)
  #   spots_path(resource)
  # end

  protected

    def configure_permitted_parameters
      added_attrs = [ :user_name, :self_introduction ]
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :user_name ])
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end

  private

    def login_required
      redirect_to root_path unless spots_path
    end
end
