Rails.application.routes.draw do
  root to: "welcome#index"

  resources :categories, param: :slug

  get "/info", to: "info#index", as: :info

  namespace :admin do
    root to: "welcome#index"
    resources :sessions, only: [:new, :create]
    resources :artist_infos, only: [:create, :update]
    resources :categories, except: :index, param: :slug do
      resources :series, except: :show do
        resources :assets, only: [:edit, :update]
      end
      patch "/:id/assets", to: "series#update_assets", as: "batch_asset_update"
      delete "/:id/assets/:asset_id", to: "series#delete_asset", as: "series_asset_delete"
    end
  end
end
