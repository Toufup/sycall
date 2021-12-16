Rails.application.routes.draw do
  # メイン
  root "home#index"
  get "/preparation", to: "home#index"
  get "/practice", to: "home#index"
  get "/login", to: "home#index"
  get "/terms", to: "home#index"
  get "/privacy", to: "home#index"
  get "/news", to: "home#index"
  get "/news/:id", to: "home#index"

  # 管理者用
  get "/admin", to: "admin/dashboard#index"
  get "/admin/*path", to: "admin/dashboard#index"

  # ユーザログイン
  devise_for :users, skip: :all
  devise_scope :user do
    post "/login", to: "users/sessions#create", defaults: { format: :json }
    delete "/logout", to: "users/sessions#destroy", defaults: { format: :json }
  end

  # API
  defaults format: :json do
    get "/calls/search", to: "calls#search"
    get "/calls/get_lyrics_count", to: "calls#get_lyrics_count"
    get "/calls/get_popular_words", to: "calls#get_popular_words"
    get "/calls/get_lyrics", to: "calls#get_lyrics"
    get "/api/news/index", to: "news#index"
    get "/api/news/:id", to: "news#show"

    scope :api do
      namespace :admin do
        resources :artists, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :songs, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :lyrics_versions, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :lyrics, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :populars, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :news, only: [:new, :index, :create, :destroy, :edit, :update]
      end
    end
  end
end
