scope module: :avocado do
  resource :email, only: %i[edit update]
  resource :profile, only: %i[edit update]
  resources :affirmations, only: %i[new create edit update]
  resources :events, only: %i[index]
  resources :registrations, only: %i[new create]
  resources :sessions, only: %i[index]
  resources :verifications, only: %i[create edit update]
end
