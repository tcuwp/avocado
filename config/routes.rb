Rails.application.routes.draw do
  scope module: :avocado do
    resources :registrations, only: %i[new create]
    resources :sessions, only: %i[index new create destroy]
  end
end
