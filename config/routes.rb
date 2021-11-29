Rails.application.routes.draw do
  root "static_pages#index"
  defaults format: :json do
    get "/calls/search", to: "calls#search"
    get "/calls/get_lyrics", to: "calls#get_lyrics"

    scope :api do
      namespace :admin do
        resources :artists
        resources :songs
      end
    end
  end
end
