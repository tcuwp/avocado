Rails.application.routes.draw do
  scope module: :avocado do
    resources :registrations, only: :new
  end
end
