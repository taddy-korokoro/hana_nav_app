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
  # インクリメンタルサーチ専用のルーティング
  get 'travel_records/search', to: 'travel_records#search'

  resources :users do
    member do
      get 'travel_record'
      get 'favorite'
      get 'like'
      # get 'following'
      # get 'follower'
    end
  end

  resources :travel_records do
    resource :likes, only: %i[create destroy]
  end

  resources :spots do
    member do
      get 'photos'
      get 'placards'
      get 'map'
    end
    resource :favorites, only: %i[create destroy]
  end
  get 'search', to: 'spots#search', as: 'search'

  post 'travel_records/:travel_record_id/comments', to: 'comments#create', as: :travel_record_comments
  delete 'travel_records/:travel_record_id/comments/:id', to: 'comments#destroy', as: :travel_record_comment
end