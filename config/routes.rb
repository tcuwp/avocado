Rails.application.routes.draw do
  scope module: :avocado do
    resources :recoveries, only: %i[new create edit update]
    resources :registrations, only: %i[new create]
    resources :sessions, only: %i[index new create destroy]
    resources :verifications, only: %i[show create]
  end
end
