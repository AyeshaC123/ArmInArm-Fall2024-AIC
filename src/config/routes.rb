# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: routes.rb
# Description: Defines URL-to-controller mappings for the application
# Last modified on: 11/29/23

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


  get 'admin/schedule_generator'
  resources :admin_panels


  get 'booker/new', to: 'booker#new', as: 'new_appointment'

  post 'booker/times', to: 'booker#times', as: 'booker_times'

  post 'booker/book', to: 'booker#book', as: 'book_appointment'

  get 'admin/schedule_generator', to: 'admin#schedule_generator', as: 'schedule_generator'

  get 'admin/show_schedule', to: 'admin#show_schedule', as: 'show_schedule'

  get 'admin/show_schedule_pdf', to: 'admin#show_schedule_pdf', as: 'show_schedule_pdf'


  delete 'booker/appointments/:id', to: 'booker#destroy', as: 'delete_appointment'

  resources :members
  resources :households
  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'
  get 'households/new'
  get 'account/index'
  get 'members/new'
  
  # Devise authentification pages. This controlls the user login
  # and authentification system.

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
  
  # Admin route
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Root route
  root 'home#index'


  resources :clients, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :new_client, only: [:index]
  resources :my_client, only: [:index]
  resources :search, only: [:index]
  # resources :appointments, only: [:index]

  
  resources :appointments


  # Devise authentication
  devise_for :users
end
