# config/routes.rb

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # Admin route
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Root route
  root 'home#index'

  # Resources for clients
  resources :clients, only: [:new, :create, :show]

  # Devise authentication
  devise_for :users

  # Your other routes can go here as needed, following the same pattern
end
