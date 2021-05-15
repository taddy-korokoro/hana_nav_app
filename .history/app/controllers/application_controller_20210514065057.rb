class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ログイン済ユーザーのみにアクセスを許可する
  # before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に遷移するパスを設定
  def after_sign_in_path_for(resource)
    spots_path(resource)
  end
  # ログアウト後に遷移するパスを設定
  def after_sign_out_path_for(resource)
    root_path(resource)
  end

  protected

    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :user_name ])
      # アカウント編集の時にnameとprofileのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update,
      keys: [ :user_name, :self_introduction, :profile_image,
              :profile_image_cache, :remove_profile_image ] )
    end
end
