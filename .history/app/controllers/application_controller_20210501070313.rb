class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ログイン済ユーザーのみにアクセスを許可する
  # before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      added_attrs = [ :user_name, :email, :password, :password_confirmation, :self_introduction ]
      devise_parameter_sanitizer.permit :sign_up, keys: [ :user_name ]
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
