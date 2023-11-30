class BookerController < ApplicationController
  def new
    @client = current_user.client if current_user.present?
  end

  def times
    @client = current_user.client if current_user.present?
    @location = params[:location]
    @date = params[:date].to_date
    @available_times = calculate_available_times(@location, @date)
    @available_times ||= ["9:00 AM", "10:00 AM", "11:00 AM"]
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
      # Redirect back to the new appointment page with a success message
      redirect_to new_appointment_path, notice: 'Appointment successfully booked!'
    else
      # Handle errors
      # You might want to show the error messages and render the 'times' view again
      render :times
    end
  end

  private

  def calculate_available_times(location, date)
    max_appointments_per_slot = 1
    available_times = []
    start_time = Time.zone.parse('9:00 AM')
    end_time = Time.zone.parse('1:00 PM')

    while start_time < end_time
      appointments_count = Appointment.where(location: location, date_of_appts: date, time_of_appts: start_time).count
      available_times << start_time.strftime('%I:%M %p') if appointments_count < max_appointments_per_slot
      start_time += 15.minutes
    end

    available_times
  end
end
