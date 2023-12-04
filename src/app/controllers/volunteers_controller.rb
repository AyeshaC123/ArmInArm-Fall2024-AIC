class VolunteersController < ApplicationController
  def upcoming_hours
    @volunteer_assignments = VolunteerAssignment.includes(:volunteer, :role, :time_slot).all
  end

  def form
    @volunteer = Volunteer.new
  end

  def index
    #@volunteers = Volunteer.new
    @volunteers = Volunteer.all
  end
  
  def create
    # Logic to handle the creation of a new volunteer

    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      #success message
      #redirect_to volunteers_path, notice: 'Volunteer was successfully created.'
      # Call the scheduling method on the instance of Volunteer
      @volunteer.schedule_volunteer
      flash[:success] = "Form submitted successfully."
      redirect_to root_path
    else
      #failure scenario
      render :new
    end
  end

  private

  # parameters for volunteer creation
  def volunteer_params
    params.require(:volunteer).permit(:volunteer_name, :volunteer_phone, :availability_day, interests: []).tap do |whitelisted|
      whitelisted[:day] = whitelisted.delete(:availability_day)
    end
  end
end