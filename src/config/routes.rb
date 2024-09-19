# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: routes.rb
# Description: Defines URL-to-controller mappings for the application
# Last modified on: 4/21/24

# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: routes.rb
# Description: defines mappings for booking appointments and check in view, also attributes the kaminari implementaitno of pagination
# Last Modified: 4/22/24


# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  resources :locations, except: [:index] do
    get 'locations_page', on: :collection
    patch 'update_location/:id', to: 'locations#update_location', as: 'update_location', on: :collection
    get 'client_view', on: :collection
  end



  #get 'volunteers/upcoming_hours'
  #get 'volunteers/form'
  get 'volunteers/upcoming_hours', to: 'volunteers#upcoming_hours', as: 'upcoming_hours'
  get 'volunteers/form', to: 'volunteers#form', as: 'volunteer_form'
 #post 'volunteers', to: 'volunteers#create'
  get 'admin/schedule_generator', to: 'admin#schedule_generator', as: 'schedule_generator'

  get 'admin/show_schedule', to: 'admin#show_schedule', as: 'show_schedule'

  get 'admin/show_schedule_pdf', to: 'admin#show_schedule_pdf', as: 'show_schedule_pdf'
  post 'volunteers/serverendpoint', to: 'volunteers#create'
  post 'clear_database', to: 'empty_data#clear_database'
  get 'upcoming_hours', to: 'volunteers#upcoming_hours'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'toggle_dyslexic_font', to: 'application#toggle_dyslexic_font'
  post 'toggle_colorblind', to: 'application#toggle_colorblind'


  get 'appointments/check_in', to: 'appointments#check_in', as:'check_in'
  get 'appointments/search', to: 'appointments#search', as: 'admin_search'
  get 'appointments/search_results', to: 'appointments#search_results', as: 'admin_search_results'



  get 'admin/schedule_generator'
  resources :admin_panels
  get 'new_event',                to: "admin_panels#new"
  get 'main_event_page',          to: "admin_panels#index"
  get 'delete_event',             to: "admin_panels#destroy"
  post 'activate_event',          to: "admin_panels#activate_event"
  post 'de_activate_event',       to: "admin_panels#de_activate_event"



  get '/graphs/nassau', to: 'graphs#nassau'
  get '/graphs/hudson', to: 'graphs#hudson'
  get '/graphs/mobile', to: 'graphs#mobile'


# This is for going into the appointments page
get 'booker/new', to: 'booker#new', as: 'new_appointment'

# This is accessed in the appointments view page
#post 'booking_times', to: 'booker#times', as: 'booker_times'
#get 'booking_times', to: 'booker#times', as: 'booker_times_get'


post 'booker/times', to: 'booker#times', as: 'booker_times'
get 'booker/times', to: redirect('/booker/new')

post 'booker/book', to: 'booker#book', as: 'book_appointment'
post 'booker/update_phone', to: 'booker#update_phone', as: 'update_phone'




  #get 'admin/schedule_generator', to: 'admin#schedule_generator', as: 'schedule_generator'

  #get 'admin/show_schedule', to: 'admin#show_schedule', as: 'show_schedule'

  #get 'admin/show_schedule_pdf', to: 'admin#show_schedule_pdf', as: 'show_schedule_pdf'


  delete 'booker/appointments/:id', to: 'booker#destroy', as: 'delete_appointment'

  resources :members
  resources :households

  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'

  get '/households', to: 'households#index'
  get 'households/new'
  get '/locations', to: 'locations#locations_page'
  post 'households/sort', to: 'households#sort'
  post 'households_create', to: 'households#create'


 # Team 22 routes used/edited
# Route for household main page
get 'households/index'

# Route for pre-registration form
# get 'households/new'

# Route for sorting the household data
post 'households/sort_asc', to: 'households#sort_asc'
post 'households/sort_desc', to: 'households#sort_desc'

# Used for upload/download feature for households
resources :households do
  # Creates route for download feature
  get 'download', on: :collection, action: :download, as: :download
  
  # Creates upload route for collection of households
  collection do
    post 'upload'
  end
  
  # Connects members resource with households
  resources :members
end

  #route for Pantry Location page
  # get '/locations', to: 'locations#locations_page'
  #route for My Account page

  get 'account/index'
  #route for creating new members for a household
  get 'members/new'
  
  # Devise authentification pages. This controlls the user login


# resources :households do
# get 'download', on: :collection, action: :download, as: :download
#   collection do
#     post 'upload'
#   end
# end

    # Devise authentification pages. This controlls the user login

  # and authentification system.

  get 'statistics/index', as: 'statistics_index'
  # get 'statistics/report_generator', as: 'stat_report_generator', to: 'reports#generate_reports'
  # get '/reports/generate_reports', as: 'stat_report_generator' , to: 'reports#generate_reports'
  get '/reports/generate_reports', as: 'stat_report_generator', to: 'reports#generate_reports'
  post '/reports/generate_reports', to: 'reports#generate_reports'

  post '/reports/generate_reports/getTableData_attendedAppointments', to: 'reports#getTableData_attendedAppointments'
  post '/reports/generate_reports/getTableData_scheduledAppointments', to: 'reports#getTableData_scheduledAppointments'
  post '/reports/generate_reports/getTableData_householdAppointments', to: 'reports#getTableData_householdAppointments'

  post '/reports/generate_reports/download_pdf', to: 'reports#prepare_pdf'
  # post '/reports/generate_reports/delete_pdf', to: 'reports#delete_pdf'

  get 'statistics/graph_generator', as: 'stat_graph_generator'
  post 'statsitics/graph_generator', to: 'graphics#generateGraph', as: 'graph_generation'
  post '/statistics/graph_generator/getBarChartData', to: 'graphics#getBarChartData'
  post '/statistics/graph_generator/getPieChartData', to: 'graphics#getPieChartData'
  post '/statistics/graph_generator/getStackedBarChartData', to: 'graphics#getStackedBarChartData'

  get 'download_pdf' => 'reports#download_pdf'
  get 'download_csv' => 'reports#download_csv'



  get 'statistics/export_report_as_csv', to: 'statistics#export_report_as_csv', as: 'export_report_as_csv'
  get 'statistics/export_report_as_pdf', to: 'statistics#export_report_as_pdf', as: 'export_report_as_pdf'

  get 'statistics/export_graph_as_pdf', to: 'statistics#export_graph_as_pdf', as: 'export_graph_as_pdf'
  # Devise authentification pages. This controlls the user login
  # and authentification system


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


  # Root route
  root 'home#index'

  get "/alert", to: "booker#alert"


  resources :clients, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  # Team 22 routes to sort client data
  post 'clients/sort_asc', to: 'clients#sort_asc'
  post 'clients/sort_desc', to: 'clients#sort_desc'
  resources :new_client, only: [:index]
  resources :my_client, only: [:index]
   resources :search, only: [:index]
  # resources :appointments, only: [:index]


  resources :appointments


  # Devise authentication
  devise_for :users


  # Route the household county drop down menu
  get '/household_county', to: 'households#county_index'

  #team 11 added this
 
  resources :households
  resources :reviews do
    member do
      patch 'approve'
      delete 'deny'
      get 'review'
    end

    
  collection do
    patch :approve_multiple
    delete :deny_multiple
  end
end
end