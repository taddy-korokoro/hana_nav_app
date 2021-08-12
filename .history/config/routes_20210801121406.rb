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
  post 'travel_records', to: 'travel_records#header_create', as: :travel_records
  get 'travel_records/header_new', to: 'travel_records#header_new', as: :header_new_travel_record

  resources :users
  resources :spots do
    member do
      get 'placards'
      get 'photos'
      get 'map'
    end
    resources :travel_records, shallow: true do
      resource :likes, only: %i[create destroy]
    end
    resource :favorites, only: %i[create destroy]
  end
  get 'search', to: 'spots#search', as: 'search'
  post 'travel_records/:travel_record_id/comments', to: 'comments#create', as: :travel_record_comments
  delete 'travel_records/:travel_record_id/comments/:id', to: 'comments#destroy', as: :travel_record_comment
end