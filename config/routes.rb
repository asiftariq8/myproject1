Rails.application.routes.draw do
  root "products#index"
  resources :products do
    collection do
      get :my_products
    end
  end


  resource :home
  devise_for :users
  resources :wishlists, only: [:create]
  get 'wishlists', to: 'wishlists#index'
  delete 'destroy_wishlists', to: 'wishlists#destroy', as: :destroy_wishlists
    
  resources :products do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
end
