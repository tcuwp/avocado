Rails.application.routes.draw do
  scope module: :avocado do
    resources :registrations, only: %i[new create]
  end
end
