class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to edit_user_registration_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
