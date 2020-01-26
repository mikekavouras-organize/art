Rails.application.routes.draw do
  root to: "welcome#index"

  resources :categories, param: :name

  namespace :admin do
    root to: "welcome#index"
    resources :sessions, only: [:new, :create]
    resources :categories, except: :index, param: :name do
      resources :pieces, except: :show
      patch "/:id/assets", to: "pieces#update_assets", as: "pieces_assets"
    end
  end
end
