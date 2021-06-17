Rails.application.routes.draw do
  resources :cart_items
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :carts, except: [:show]
  resources :items

  resources :users, only: [:update, :show]
  get 'profile', to: 'users#profile'
  get 'mycart', to: 'carts#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
