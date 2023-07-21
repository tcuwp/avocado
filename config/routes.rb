Rails.application.routes.draw do
  scope module: :avocado do
    resource :email, only: %i[edit update]
    resource :password, only: %i[edit update]
    resources :affirmations, only: %i[new create edit update]
    resources :events, only: %i[index]
    resources :recoveries, only: %i[new create edit update]
    resources :registrations, only: %i[new create]
    resources :sessions, only: %i[index new create destroy]
    resources :verifications, only: %i[create edit update]
  end
end
