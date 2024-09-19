# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: booker_controller.rb
# Description: Controller for booking appointments, includes functions to limit number of appointments and filter available times

# Last modified on: 11/29/23

# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: booker_controller.rb
# Description: controller which handles the functionality of booking appointments. Adds constraints to handle abuses/misuses
# Last Modified: 4/22/24
# Last modified on: 4/21/24 


class BookerController < ApplicationController
  include BookerHelper
  include Kaminari::PageScopeMethods
  include TimeHelperModule

  before_action :check_authority, only: %i[ time ]

  def new
    @client = current_user.client if current_user.present?

    @location = params[ :user_default_location ]


    @events = AdminPanel.where(event_active: true) # Fetch active events







    @admin_panel = AdminPanel.first
    @cliCurAppt = cli_cur_appt_retrieve # holds list of client unchecked appointments, used as "existing appointments"
    @cliPastAppt = past_appt_cli_list # holds list of admin/client checked in appointments
    

    @events = AdminPanel.where(event_active: true) # Fetch active events
  end


  #updates prefered phone number for reminder texts
  def update_phone
    @client = current_user.client
    if @client.update(phone_number: params[:phone_number])
      flash[:notice] = 'Phone number updated successfully!'
      redirect_to new_appointment_path
    else
      flash[:error] = 'Failed to update phone number.'
      render :new
    end
  end

  def times
    Rails.logger.debug "Incoming parameters: #{params.inspect}"
    @client = current_user.client if current_user.present?
    
    # parameters from the buttons pressed
    @location = params[:default_location]
    
    # Check if the date parameter is present
    if params[:date].present?
      @date = params[:date].to_date
    else
      flash[:msg] = 'Date must be selected'
      return redirect_to new_appointment_path
    end
  
    # Extracting event_id_list from params
    @event_id_list = params[:event_id_list]
  
    # Adding detailed debug information
    if @event_id_list.nil?
      Rails.logger.error "event_id_list is nil after extraction from params!"
    else
      Rails.logger.debug "event_id_list after extraction: #{@event_id_list.inspect}"
    end
  
    # Handle the case where event_id_list is expected but not provided
    if @event_id_list.blank?
      flash[:alert] = 'No events selected. Please select at least one event.'
      return redirect_to new_appointment_path
    end
  
    # Converting event_id_list to an array of integers if necessary
    @event_id_list = @event_id_list.map(&:to_i) if @event_id_list.is_a?(Array)
    Rails.logger.debug "event_id_list after conversion to integers: #{@event_id_list.inspect}"
  
    # A 2D array that contains both the start time that will be displayed, and the remaining appointment count
    @available_times_hash = Hash.new
  
    # This is to ensure no appointments are made in case one exists this week
    if has_appointment_this_week?
      flash[:msg] = 'You already have an appointment this week. Please choose a different week.'
      return redirect_to new_appointment_path
    elsif has_household_appointment_this_week?
      flash[:msg] = 'Someone in your house already has an appointment for this week. Please choose a different week.'
      return redirect_to new_appointment_path
    end
  
    # The hash function is filled in while in this method
    calculate_available_times
  end
  
  
  

  #deletion
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_back(fallback_location: root_path, notice: 'Appointment deleted successfully')
  end

  def book
    @client = current_user.client if current_user.present?
    @appointment = Appointment.new(
      client_id: @client.id,
      location: params[:location],
      date_of_appts: params[:date_of_appts],
      time_of_appts: Time.zone.parse("#{params[:date_of_appts]} #{params[:time_of_appts]}"),
      first_name: @client.first_name,
      last_name: @client.last_name,
      dob: @client.dob,
      admin_panels_id: params[:event_id]
    )

    if @appointment.save
      redirect_to new_appointment_path, notice: 'Appointment successfully booked!'
    else
      flash[:alert] = 'Appointment could not be booked!'
      render :new
    end
  end


  private
    def check_authority

      if ( !current_user.registered )
        # regular users do not have access to the Admins panenl
        redirect_to root_path
      end

    end

    # Limits client appointments to one per week
    def has_appointment_this_week?( )
      start_of_week = @date.beginning_of_week
      end_of_week = @date.end_of_week

      @client.appointments.where("date_of_appts >= ? AND date_of_appts <= ?", start_of_week, end_of_week).exists?
    end

    def has_household_appointment_this_week?( )

      # this checks wether an appointment exists 
      # based on two criterias ( household name, and adress )

      start_of_week = @date.beginning_of_week
      end_of_week = @date.end_of_week

      # getting the clients household head name
      household_head_name =  Household.where( user_id: current_user.id )[0].headname

      # getting the clients household address
      household_address =  Household.where( user_id: current_user.id )[0].streetaddr


      # getting all the household members via the household headname
      # and then checking if any of them have an appointment at the time which the person is clicking
      Household.where( headname: household_head_name, streetaddr: household_address ).each do | household |

        # if anyone with the user id found in the household is found to have that same appointment
        if ( User.find_by(id: household.user_id ).client.appointments.where("date_of_appts >= ? AND date_of_appts <= ?", start_of_week, end_of_week).exists? ) 

          flash[:msg] = 'Someone in you house already has an appointment for this week. Please choose a different week.'
          return true

        end

      end
      return false


    end

    def calculate_available_times
      if @event_id_list.nil?
        Rails.logger.error "event_id_list is nil inside calculate_available_times!"
        return
      end
    
      Rails.logger.debug "Inside calculate_available_times. event_id_list: #{@event_id_list.inspect}"
    
      @event_id_list.each do |event_id_string|
        # Creating a hash that will house all the event times.
        @available_times_hash[event_id_string] = []
    
        # Getting the event
        admin_panels_event = AdminPanel.find_by(id: event_id_string.to_i)
        if admin_panels_event.nil?
          Rails.logger.error "AdminPanel event not found for id: #{event_id_string}"
          next
        end
    
        max_appointments_per_block = admin_panels_event.max_appointment_count
    
        # Get the start and end time for the event in question
        start_time = add_date_to_time(Time.parse(admin_panels_event.start_time.to_s), @date)
        end_time = add_date_to_time(Time.parse(admin_panels_event.end_time.to_s), @date)
    
        # AM vs. PM needs to be separated
        am_list = []
        pm_list = []
    
        # This portion calculates the number of appointments left for a certain time range
        while start_time < end_time
          appointments_count = Appointment.where(location: @location, date_of_appts: @date, time_of_appts: start_time).count
    
          # Verify that current time (in EST or EDT) is not after the start time (converted to EST or EDT)
          start_datetime = add_date_to_time(start_time, @date)
          if (appointments_count < max_appointments_per_block) && (Time.current.in_time_zone('Eastern Time (US & Canada)') < start_datetime.in_time_zone('Eastern Time (US & Canada)'))
            if start_time.strftime('%p') == 'AM'
              am_list.push([start_time.strftime('%I:%M %p'), (max_appointments_per_block - appointments_count)])
            else
              pm_list.push([start_time.strftime('%I:%M %p'), (max_appointments_per_block - appointments_count)])
            end
          end
    
          start_time += admin_panels_event.appointment_length.minutes
        end
    
        @available_times_hash[event_id_string] = am_list.concat(pm_list)
      end
    end
    



end