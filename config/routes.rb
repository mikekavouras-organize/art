Rails.application.routes.draw do
  root to: "welcome#index"

  namespace :admin do
    root to: "welcome#index"
    resources :users, only: [:new]

    post 'login', to: 'sessions#create'
  end
end
