Rails.application.routes.draw do
  root to: 'orders#new'

  resources :orders, only: [:index, :create]
end
