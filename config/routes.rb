Rails.application.routes.draw do
  resources :cart_items
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :carts, except: [:show]
  resources :items
  resources :orders, only: [:create]

  resources :users, only: [:update, :show]
  get 'profile', to: 'users#profile'
  get 'mycart', to: 'carts#show'

  # Route Stripe Checkout
  post 'create-checkout-session/:id', to: 'orders#create_payment', as: 'create-checkout-session'
  devise_scope :admin do
    root to: "devise/sessions#new"
  end
end
