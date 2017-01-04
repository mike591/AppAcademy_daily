Rails.application.routes.draw do
  root to: "static_pages#root"

  namespace :api, defaults: {format: :json}  do
    resources :todos, only: [:index, :show, :create, :update, :destroy]
    resources :steps, only: [:index, :create, :update, :destroy]
  end
end
