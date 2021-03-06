Rails.application.routes.draw do
  resources :cart_items
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :carts, except: [:show]
  resources :items
  resources :orders, only: [:create]
  resources :store_locations, only: [:index]
  resources :newsletter_subscribers, only: [:create]

  resources :users, only: [:update, :show]
  get 'profile', to: 'users#profile'
  get 'mycart', to: 'carts#show'

  # Route Stripe Checkout
  post 'create-checkout-session/:id', to: 'orders#create_payment', as: 'create-checkout-session'
  as :admin do
   authenticated :admin do
     root 'rails_admin/main#dashboard', as: :authenticated_root
   end

   unauthenticated do
     root 'devise/sessions#new', as: :unauthenticated_root
   end
 end
end
