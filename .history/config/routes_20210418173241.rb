Rails.application.routes.draw do
  get 'top/home'
  root 'top_pages#home'
end
