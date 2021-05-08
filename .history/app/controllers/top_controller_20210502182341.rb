class TopController < ApplicationController
  def home
    if user_signed_in?
      render template: 'spots/index' # ログイン済みのトップ画面
    end
end
