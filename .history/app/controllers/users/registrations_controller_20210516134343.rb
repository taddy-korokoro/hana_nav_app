class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy

  # ゲストユーザーを削除させないようにする設定
  def ensure_normal_user
    if resource.email == 'guest@exsample.com'
      redirect_to spots_path, alert: "ゲストユーザーは削除できません。"
    end
  end

protected
#  アカウント編集後、プロフィール画面に移動する
  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end

# パスワード入力せずにプロフィール編集
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
