Rails.application.routes.draw do
  resources :articles, only: [:index, :show]
  root 'articles#index'
end
