class AdminController < ApplicationController
  def schedule_generator
  end

  def show_schedule
    if params[:date].present?
      @selected_date = params[:date].to_date
      @selected_location = params[:location]
      @appointments = Appointment.where(date_of_appts: @selected_date, location: @selected_location)
    end
  end
end
