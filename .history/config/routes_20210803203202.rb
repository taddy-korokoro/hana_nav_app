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
  get 'travel_records/search', to: 'travel_records#search'

  # resources :travel_records, only: %i[new create]
  # ヘッダーフォームから新規投稿
  # post 'travel_records', to: 'travel_records#header_create', as: :travel_records
  # get 'travel_records/header_new', to: 'travel_records#header_new', as: :header_new_travel_record

  get 'travel_records', to: 'travel_records#index', as: :travel_records
  post 'travel_records/spots/spot_id', to: 'travel_records#create', as: :create_travel_record
  get 'travel_records/new', to: 'travel_records#new', as: :new_travel_record
  get 'travel_records/:id/edit', to: 'travel_records#edit', as: :edit_travel_record
  get 'travel_records/:id', to: 'travel_records#show', as: :travel_record
  patch 'travel_records/:id', to: 'travel_records#update', as: :update_travel_record
  put 'travel_records/:id', to: 'travel_records#update', as: :put_travel_record
  delete 'travel_records/:id', to: 'travel_records#destroy', as: :destroy_travel_record

  post 'travel_records/:travel_record_id/likes', to: 'likes#create'
  delete 'travel_records/:travel_record_id/likes', to: 'likes#destroy'

  resources :users
  resources :spots do
    get 'search', to: 'spots#search', as: 'search'
    member do
      get 'placards'
      get 'photos'
      get 'map'
    end
    resource :favorites, only: %i[create destroy]
  end
  resources :travel_records do
    resource :likes, only: %i[create destroy]
  end
  post 'travel_records/:travel_record_id/comments', to: 'comments#create', as: :travel_record_comments
  delete 'travel_records/:travel_record_id/comments/:id', to: 'comments#destroy', as: :travel_record_comment
end