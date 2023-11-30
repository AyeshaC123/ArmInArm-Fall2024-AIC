# frozen_string_literal: true

# This file tells the Rails server how incoming requests are sent to which
# controller and method.
#
#
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  #get 'volunteers/upcoming_hours'
  #get 'volunteers/form'
  get 'volunteers/upcoming_hours', to: 'volunteers#upcoming_hours', as: 'upcoming_hours'
  get 'volunteers/form', to: 'volunteers#form', as: 'volunteer_form'
 #post 'volunteers', to: 'volunteers#create'
  post 'volunteers/serverendpoint', to: 'volunteers#create'
  post 'clear_database', to: 'empty_data#clear_database'
  get 'upcoming_hours', to: 'volunteers#upcoming_hours'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'
  root 'home#index'
  # Devise authentification pages. This controlls the user login
  # and authentification system.
  devise_for :users

  # Examples:
  #
  # # Add app CRUD operations from a controller. Used with scaffolding.
  # # CRUD -> create (API/POST), new (page/GET), index, show,
  #           edit(page/GET), update(API/PATCH|PUT), destroy(API/DELETE)
  # resources :my_controller
  #
  # # Add GET path for photos controller, index method
  # get 'photos/index'
  #
  # # Resources, but only register these methods
  # resources :photos, only: [:index, :new, :create, :destroy]
  #resources :volunteers, only: [:new, :create]
  resources :volunteers
  #
  # # Add PUT path for the given url, but send it to a different controller
  # # than rails would assume by the name. to: 'controller#method_name'.
  # # It would have extected to: 'add_tags#add', which would fail
  # put '/add_tags/add', to: 'users#add_tags'
  
end
