Rails.application.routes.draw do
  root "home#index"
  get "/preparation", to: "home#index"
  get "/practice", to: "home#index"

  get "/admin", to: "admin/dashboard#index"
  get "/admin/*path", to: "admin/dashboard#index"

  defaults format: :json do
    get "/calls/search", to: "calls#search"
    get "/calls/get_lyrics", to: "calls#get_lyrics"

    scope :api do
      namespace :admin do
        resources :artists, only: [:new, :index, :create, :destroy, :edit, :update]
        get "artists/search_artists", to: "artists#search_artists"
        resources :songs, only: [:new, :index, :create, :destroy, :edit, :update]
        get "songs/search_songs", to: "songs#search_songs"
        resources :lyrics_versions, only: [:new, :index, :create, :destroy, :edit, :update]
        get "lyrics_versions/search_versions", to: "lyrics_versions#search_versions"
        resources :lyrics, only: [:new, :index, :create, :destroy, :edit, :update]
      end
    end
  end
end
