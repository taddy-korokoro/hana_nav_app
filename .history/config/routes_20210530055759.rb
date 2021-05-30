Rails.application.routes.draw do
  root 'top#home'
  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    # ゲストログイン用
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users
  resources :spots
  get 'search', to: 'spots#search', as: 'search'
end