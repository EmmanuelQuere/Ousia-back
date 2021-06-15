Rails.application.routes.draw do
  resources :carts
  resources :items
  devise_for :users

  resources :users, only: [:update, :show]
  get 'profile', to: 'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
