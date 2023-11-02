class VolunteersController < ApplicationController
  def upcoming_hours
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
      redirect_to volunteers_path, notice: 'Volunteer was successfully created.'
    else
      #failure scenario
      render :new
    end
  end

  private

  # parameters for volunteer creation
   def volunteer_params
     params.require(:volunteer).permit(:volunteer_name, :volunteer_phone, interests: [])
   end
end
