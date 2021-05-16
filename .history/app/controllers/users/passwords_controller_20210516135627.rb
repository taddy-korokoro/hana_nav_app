class Users::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: :create

  def ensure_normal_user
    if params[:user][:email].downcase == 'guest@exsample.com'
      redirect_to new_user_sessions_path,
      alert: "ゲストユーザーのパスワード制設定はできません。"
    end
  end
end
