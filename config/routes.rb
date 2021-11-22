Rails.application.routes.draw do
  root "static_pages#index"
  get "/calls/search", to: "calls#search", defaults: { format: :json }
end
