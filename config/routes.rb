Rails.application.routes.draw do
  root "static_pages#index"
  get "/calls/search", to: "calls#search", defaults: { format: :json }
  get "/calls/get_lyrics", to: "calls#get_lyrics", defaults: { format: :json }
end
