Rails.application.routes.draw do
  root to: "welcome#index"

  resources :categories, param: :slug

  namespace :admin do
    root to: "welcome#index"
    resources :sessions, only: [:new, :create]
    resources :categories, except: :index, param: :slug do
      resources :pieces, except: :show do
        resources :assets, only: [:edit, :update]
      end
      patch "/:id/assets", to: "pieces#update_assets", as: "batch_asset_update"
      delete "/:id/assets/:asset_id", to: "pieces#delete_asset", as: "piece_asset_delete"
    end
  end
end
