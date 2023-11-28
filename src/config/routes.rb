# config/routes.rb

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  resources :admin_panels

  # Admin route
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Root route
  root 'home#index'

  # Resources for clients
  resources :clients, only: [:new, :create, :show]
  resources :booker, only: [:new, :create, :show]


  resources :new_client, only: [:index]
  resources :search, only: [:index]
  # resources :appointments, only: [:index]

  
  resources :appointments

  # Devise authentication
  devise_for :users
end
