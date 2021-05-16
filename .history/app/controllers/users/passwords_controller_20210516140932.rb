class Users::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: :create

  # ゲストユーザーがパスワード再設定できないようにする
  def ensure_normal_user
    if params[:user][:email].downcase == 'guest@exsample.com'
      redirect_to new_user_session_path,
      alert: "ゲストユーザーのパスワード再設定はできません。"
    end
  end
end
