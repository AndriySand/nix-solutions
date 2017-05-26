Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  namespace :api, defaults: {format: :json} do
    resources :posts, only: [:index, :show]
  end

  root 'posts#index'
end
