class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に遷移するパスを設定
  def after_sign_in_path_for(resource)
    spots_path
  end
  # ログアウト後に遷移するパスを設定
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

    def configure_permitted_parameters
      # サインアップ時にストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
      # アカウント編集の時にストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update,
      keys: [ :name, :self_introduction, :profile_image,
              :profile_image_cache, :remove_profile_image ] )
    end
end
