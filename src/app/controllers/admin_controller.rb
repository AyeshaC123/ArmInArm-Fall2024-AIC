# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: admin_controller.rb
# Description: Simple controller to show the appointments for parameters location and date
# Last modified on: 11/29/23


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
