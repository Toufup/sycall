Rails.application.routes.draw do
  root "static_pages#index"
  defaults format: :json do
    get "/calls/search", to: "calls#search"
    get "/calls/get_lyrics", to: "calls#get_lyrics"

    get "/api/admin/artists", to: "admin/artists#index"
    post "/api/admin/artists", to: "admin/artists#create"
  end
end
