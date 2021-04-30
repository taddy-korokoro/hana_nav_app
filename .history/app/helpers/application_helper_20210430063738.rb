module ApplicationHelper
  def devise_controller_class
    devise_controller? ? 'mw-md' : 'mw-xl'
  end
end
