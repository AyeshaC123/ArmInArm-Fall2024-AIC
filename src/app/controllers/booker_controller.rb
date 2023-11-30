# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: booker_controller.rb
# Description: Controller for booking appointments, includes functions to limit number of appointments and filter available times
# Last modified on: 11/29/23

class BookerController < ApplicationController

  def new
    @client = current_user.client if current_user.present?
  end

  def times
    @client = current_user.client if current_user.present?
    @location = params[:location]
    @date = params[:date].to_date
  
    if has_appointment_this_week?(@client, @date)
      flash.now[:alert] = 'You already have an appointment this week. Please choose a different week.'
      render :new and return
    end
  
    @available_times = calculate_available_times(@location, @date)
  end

  #deletion
  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment was successfully destroyed.'
  end

  def book
    @client = current_user.client if current_user.present?
    @appointment = Appointment.new(
      client_id: @client.id, 
      location: params[:location], 
      date_of_appts: params[:date], 
      time_of_appts: Time.zone.parse("#{params[:date]} #{params[:time]}"),
      last_name: @client.last_name,
      dob: @client.dob               
    )


    if @appointment.save
      redirect_to new_appointment_path, notice: 'Appointment successfully booked!'
    else
      
      render :times
    end
  end

  private

  # Limits client appointments to one per week
  def has_appointment_this_week?(client, date)
    start_of_week = date.beginning_of_week
    end_of_week = date.end_of_week

    client.appointments.where("date_of_appts >= ? AND date_of_appts <= ?", start_of_week, end_of_week).exists?
  end


    def calculate_available_times(location, date)
      # Gets the first row of the admin panel database
      admin_panel = AdminPanel.first 
    
      # Default to 1 if no admin_panel record is found
      max_appointments_per_slot = admin_panel.max_appointment_count
    
      available_times = []
    
      if admin_panel.booking_days&.include?(date.strftime('%A'))

        start_time = Time.zone.parse(admin_panel.start_time.to_s)
        end_time = Time.zone.parse(admin_panel.end_time.to_s)
    
        while start_time < end_time
          
          appointments_count = Appointment.where(location: location, date_of_appts: date, time_of_appts: start_time).count
          available_times << start_time.strftime('%I:%M %p') if appointments_count < max_appointments_per_slot
    
          start_time += admin_panel.appointment_length.minutes
        end
      end
    
      available_times
    end
    
  
end

