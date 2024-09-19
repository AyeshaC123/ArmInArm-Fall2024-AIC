# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: appointments_controller.rb
# Description: Controller for initial appointments page, where the clients interactons to see times and their made appointments are shown
# Last modified on: 11/29/23

# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: appointments_controller.rb
# Description: controller for managing appointments and check-ins
# Last Modified: 4/22/24



class AppointmentsController < ApplicationController


  include AppointmentsHelper
  before_action :check_authority


  # this is a action that directs users to the check in page
  def check_in( )


    # this variable is to be used by the regular clients
    @user = current_user

    # only the amin will use this variable
    @users = User.all

    # variables used for pagination, listing appointments
    @cliApptChecked = past_appt_cli_list # list of admin checked appointments for client
    @cliApptUnchecked = Appointment.where(check_in_user: false, client_id: @user.client_id).page(params[:pageFut]).per(10)

    @is_admin = (@user.admin == 1) ? true : false

    # if admin, set-up all appointments in categories (upcoming, previously check-in, previously uncheck-in).
    if @is_admin
      @today = Date.today
      @start_of_week = Date.today.beginning_of_week
      @end_of_week = Date.today.end_of_week

      upcoming_appointments = Appointment.where("date_of_appts >= ?", @today)
      upcoming_appointments_dates = collect_appointment_category_dates(upcoming_appointments)
      upcoming_appointments_dates = date_bubble_sort(upcoming_appointments_dates)

      upcoming_appointments_dates.each do |element|
        element.push(Appointment.where("date_of_appts = ? AND check_in_user = FALSE", element[1]).order(:time_of_appts, :last_name))
        element.push(Appointment.where("date_of_appts = ? AND check_in_user = TRUE", element[1]).order(:time_of_appts, :last_name))
        element.delete_at(1)
      end

      previous_checked_in_appointments = Appointment.where("date_of_appts < ? AND (client_self_check_in = TRUE OR check_in_user = TRUE)", @start_of_week)
      previous_checked_in_appointments_dates = collect_appointment_category_dates(previous_checked_in_appointments)
      previous_checked_in_appointments_dates = date_bubble_sort(previous_checked_in_appointments_dates)



      previous_checked_in_appointments_dates.each do |element|
        element.push(Appointment.where("date_of_appts = ? AND (client_self_check_in = TRUE OR check_in_user = TRUE)", element[1]).order(:time_of_appts, :last_name))
        element.delete_at(1)
      end

      previous_unchecked_in_appointments = Appointment.where("date_of_appts < ? AND (client_self_check_in = FALSE AND check_in_user = FALSE)", @start_of_week)
      previous_unchecked_in_appointments_dates = collect_appointment_category_dates(previous_unchecked_in_appointments)
      previous_unchecked_in_appointments_dates = date_bubble_sort(previous_unchecked_in_appointments_dates)

      previous_unchecked_in_appointments_dates.each do |element|
        element.push(Appointment.where("date_of_appts = ? AND (client_self_check_in = FALSE AND check_in_user = FALSE)", element[1]).order(:time_of_appts, :last_name))
        element.delete_at(1)
      end

      # data to send to admin check-in view
      @data = {
        "upcoming_appointments" => upcoming_appointments_dates,

        "previous_checked_in_appointments" => previous_checked_in_appointments_dates,

        "previous_unchecked_in_appointments" => previous_unchecked_in_appointments_dates,

        "today" => @today
      }
    end

    return render check_in_path


  end

  # this function handles all the checnges when a user presses the check in button
  def check_them_in()

    # this is initially false
    @from_search = false 

    # if this check-in was from the search results page, assign values accordingly.
    if params["from_search"] == "true"
      @first_name = params["query_data"]["first_name"]
      @last_name = params["query_data"]["last_name"]
      @start_date = params["query_data"]["start_date"]
      @end_date = params["query_data"]["end_date"]
      @from_search = true
    end

    # this is a string
    who_is_doing_the_check_in = params[:who_is_doing_the_check_in]

    #  this is an integer
    appointment_id = params[:appointment_id].to_i



    if ( who_is_doing_the_check_in != "admin")
      # the user is doing the change here

      appointment = Appointment.find_by( id: appointment_id )
      appointment.client_self_check_in = true

      appointment.save

    else
      # the admin is checking in the user

      appointment = Appointment.find_by( id: appointment_id )
      appointment.check_in_user = true

      appointment.save


    end

    # params to send to loader view.
    response_params = {:from_search => @from_search, :first_name => @first_name, :last_name => @last_name, :start_date => @start_date, :end_date => @end_date}

    redirect_to loader_path(:response_data => response_params)
  end





  # only an admin will be able to sign people out
  def check_them_out()

    # this is initially false
    @from_search = false

    # if this check-in was from the search results page, assign values accordingly.
    if params["from_search"] == "true"
      @first_name = params["query_data"]['first_name']
      @last_name = params["query_data"]['last_name']
      @start_date = params["query_data"]['start_date']
      @end_date = params["query_data"]['end_date']
      @from_search = true
    end



    #  this is an integer
    appointment_id = params[:appointment_id].to_i


    appointment = Appointment.find_by( id: appointment_id )
    appointment.check_in_user = false

    appointment.save

    # params to send to loader view.
    response_params = {:from_search => @from_search, :first_name => @first_name, :last_name => @last_name, :start_date => @start_date, :end_date => @end_date}

    redirect_to loader_path(:response_data => response_params)

  end


  def new
      @appointment = Appointment.new

    if where.empty?
      # No search.
      @has_searched = false
      @clients = Client.none
    else  
      # Do search.
      @has_searched = true
      @clients = Client.where([where.join(' and ')] + values)
    end
  end

  def search
    @user = current_user

    # checks if user is an admin
    @is_admin = (@user.admin == 1) ? true : false

    render 'admin_search'
  end


  def search_results

    # filter array that will eventually be added to the where clause of SQL query.
    filter = []
    @today = Date.today


    # if the user submitted a first name, add it to filter array.
    if !params["first_name"].blank?
      filter << "lower(first_name) = \'#{params["first_name"].downcase}\'"
    end


    # if the user submitted a last name, add it to filter array.
    if !params["last_name"].blank?
      filter << "lower(last_name) = \'#{params["last_name"].downcase}\'"
    end

    # if the user submitted both a start date and a end date, add this to the query
    if !params["start_date"].blank? and !params["end_date"].blank?
      filter << "date_of_appts BETWEEN \'#{params["start_date"].to_s}\' AND \'#{params["end_date"].to_s}\'"
    
    # if user submitted only a start date, add this to the query
    elsif !params["start_date"].blank?
      filter << "date_of_appts >= \'#{params["start_date"].to_s}\'"
    
    # if user submitted only a end date, add this to the query
    elsif !params["end_date"].blank?
      filter << "date_of_appts <= \'#{params["end_date"].to_s}\'"
    end

    # params to send to search results view; is used when admin checks-in an appointment.
    @query_params =  {:first_name => params["first_name"], :last_name => params["last_name"], :start_date => params["start_date"], :end_date => params["end_date"]}


    # makes where statement
    where_statement = filter.join(" AND ")

    # find appointments that fits given filters
    @filtered_appointments = Appointment.where(where_statement).order(:date_of_appts, :time_of_appts, :last_name)

    render 'search_results'
  end

  private

    def check_authority



      if (current_user.admin == 0) and ( !current_user.registered  )
        # regular users do not have access to the Admins panenl
        redirect_to root_path
        # redirect_to root_path
      end

    end

    # needed
    def collect_appointment_category_dates(arr)
      dates_arr = []

      arr.each do |element|
        the_date = element.date_of_appts.strftime('%B %d, %Y')
        date_found = false
        for el in dates_arr do

          if el[0] == the_date
            date_found = true
          end
        end

        if date_found == false
          dates_arr << [the_date, element.date_of_appts] 
        end
      end

      return dates_arr
    end 

    # needed
    # bubble sort to dates. Could be redundant. I'm sure there's a more efficient solution.
    def date_bubble_sort(arr)
      length = arr.length
      loop do
        swapped = false

        (length-1).times do |i|
          if arr[i][1] > arr[i+1][1]
            arr[i], arr[i+1] = arr[i+1], arr[i]
            swapped = true
          end
        end

        break if not swapped
      end

      return arr
    end
end
