class VolunteersController < ApplicationController
  def upcoming_hours
    @volunteer_assignments = VolunteerAssignment.includes(:volunteer, :role, :time_slot).all
  end

  def form
    @volunteer = Volunteer.new
  end

  def index
    @volunteers = Volunteer.all
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      @volunteer.schedule_volunteer
      flash[:success] = "Form submitted successfully."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:volunteer_name, :volunteer_phone, :day, interests: [])
  end
end
