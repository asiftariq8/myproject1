Rails.application.routes.draw do
   root "home#index"
  #  get 'home/index', to: 'home#index'
  resource :home
  devise_for :users
  # resources :products
  # resources :wishlists, only: [:create, :destroy]
end
