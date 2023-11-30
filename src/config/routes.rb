# config/routes.rb

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do


  resources :admin_panels


  get 'booker/new', to: 'booker#new', as: 'new_appointment'

  post 'booker/times', to: 'booker#times', as: 'booker_times'

  post 'booker/book', to: 'booker#book', as: 'book_appointment'


  resources :households
  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'
  get 'households/new'
  get 'account/index'
  
  get '/apointments/display_wait_Nassau', to: redirect('/')
  
  # Devise authentification pages. This controlls the user login
  # and authentification system.

  # Admin route
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Root route
  root 'home#index'

  # Resources for clients

  resources :clients, only: [:new, :create, :show, :edit, :update]

  resources :new_client, only: [:index]
  resources :my_client, only: [:index]
  resources :search, only: [:index]
  # resources :appointments, only: [:index]

  
  resources :appointments

  # Devise authentication
  devise_for :users
end
