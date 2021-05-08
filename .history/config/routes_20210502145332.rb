Rails.application.routes.draw do
  root 'top#home'
  get 'search' to: 'top#index'
  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  resources :users, only: [:show]
  resources :spots, only: [:index]
end