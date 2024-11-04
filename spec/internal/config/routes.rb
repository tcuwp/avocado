Rails.application.routes.draw do
  root to: "languages#index"

  # From rails generator
  resource :session
  resources :passwords, param: :token

  # Added by gem
  draw(🥑)
end
