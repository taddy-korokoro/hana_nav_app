module ApplicationHelper
  # devise 関連のページのみ最大の横幅を700pxとして，それ以外は1200px
  def devise_controller_class
    devise_controller? ? 'mw-md' : 'mw-xl'
  end
end
