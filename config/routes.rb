Rails.application.routes.draw do
  scope module: :avocado do
    resources :registrations, only: %i[new create]
    resources :sessions, only: %i[new create]
  end
end
