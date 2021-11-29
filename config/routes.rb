Rails.application.routes.draw do
  root "static_pages#index"
  defaults format: :json do
    get "/calls/search", to: "calls#search"
    get "/calls/get_lyrics", to: "calls#get_lyrics"

    scope :api do
      namespace :admin do
        resources :artists, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :songs, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :lyrics_versions, only: [:new, :index, :create, :destroy, :edit, :update]
        resources :lyrics, only: [:new, :index, :create, :destroy, :edit, :update]
      end
    end
  end
end
