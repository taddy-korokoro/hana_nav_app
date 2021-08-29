Rails.application.routes.draw do
  root 'top#home'
  get 'index', to: 'top#index', as: 'index'
  get 'search', to: 'top#search', as: 'search'

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

  resources :users, only: %i[index] do
    member do
      get 'travel_records', 'favorites', 'likes', 'followings', 'followers', 'feeds'
    end
    collection do
      get 'search'
    end
  end
  resources :relationships, only: %i[create destroy]

  resources :travel_records do
    collection do
      get 'search' # インクリメンタルサーチ専用のルーティング
    end
    resource :likes, only: %i[create destroy]
    resource :comments, only: %i[create destroy]
  end

  post 'travel_records/:travel_record_id/comments', to: 'comments#create', as: :travel_record_comments
  delete 'travel_records/:travel_record_id/comments/:id', to: 'comments#destroy', as: :travel_record_comment

  resources :spots, only: %i[show] do
    member do
      get 'photos','placards', 'map'
    end
    resource :favorites, only: %i[create destroy]
  end

  resources :flower_items, only: %i[index show]
end