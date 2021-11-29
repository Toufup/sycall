Rails.application.routes.draw do
  root "static_pages#index"
  defaults format: :json do
    get "/calls/search", to: "calls#search"
    get "/calls/get_lyrics", to: "calls#get_lyrics"

    scope :api do
      namespace :admin do
        resources :artists, only: [:show, :index, :create, :destroy, :update]
        resources :songs, only: [:show, :index, :create, :destroy, :update]
      end
    end
  end
end
