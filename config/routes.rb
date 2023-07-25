Rails.application.routes.draw do root to: "welcome#index"
  resources :categories, param: :slug

  get "/info", to: "info#index", as: :info
  get "/cv", to: "info#cv", as: :cv

  namespace :admin do
    root to: "welcome#index"
    namespace :welcome do
      post :update_category_positions, to: "update_category_positions", as: "update_category_positions"
    end
    resources :resumes
    resources :sessions, only: [:new, :create]
    resources :artist_infos, only: [:create, :update]
    resource :headshots, only: [:create, :destroy]
    resources :categories, except: :index, param: :slug do
      post :update_positions, to: "categories#update_positions", as: "update_positions"
      post :update_series_positions, to: "categories#update_series_positions", as: "update_series_positions"
      resources :series, except: :show do
        resources :assets, only: [:edit, :update]
      end
      patch "/:id/assets", to: "series#update_assets", as: "batch_asset_update"
      delete "/:id/assets/:asset_id", to: "series#delete_asset", as: "series_asset_delete"
    end
  end
end
