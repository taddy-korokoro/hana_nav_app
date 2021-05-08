class TopController < ApplicationController
  def home
    if user_signed_in?
      render 'spots/index' # ログイン済みのトップ画面
    else
      render 'home' # ログインしてないトップ画面
    end
  end
end
