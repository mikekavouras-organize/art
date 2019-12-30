Rails.application.routes.draw do
  root to: "welcome#index"

  namespace :admin do
    root to: "welcome#index"
    resources :sessions, only: [:new, :create]


  end
end
