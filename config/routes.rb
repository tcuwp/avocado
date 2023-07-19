Rails.application.routes.draw do
  scope module: :avocado do
    resource :recovery, only: %i[new create edit update]
    resources :verifications, only: %i[show create]
    resources :registrations, only: %i[new create]
    resources :sessions, only: %i[index new create destroy]
  end
end
