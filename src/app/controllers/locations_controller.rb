# Project Name: Admin Dashboard - Team 22
# Description: Allows admin to view & edit household, client, & location data
# Filename: locations_controller.rb
# Description: This controller is responsible for tracking pantry location data
#   so admin can add, edit, and delete data
#   Also allows non-admin users to view all available pantry locations.
# Last Modified: 4/28/2024

class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = Location.all
  end

  def locations_page # For the admin view
    @locations = Location.order(:id)
  end

  def client_view # For the client view
    @locations = Location.order(:id)
  end
  

  def update_location # Updates the location when the edit button is pressed
    location = Location.find(params[:id])
    if location.update(location_params)
      redirect_to locations_page_locations_path, notice: 'Location updated successfully.'
    else
      render locations_page_locations_path, alert: 'Failed to update location.'
    end
  end

  def create #Creates a new location if the create button is pressed
    @location = Location.new(location_params)
    if @location.save #If the location is saveable (i.e. all fields are filled out)
      redirect_to locations_page_locations_path, notice: 'Location created successfully.'
    else #If a field is not filled out 
      @locations = Location.order(:id)
      flash.now[:alert] = 'Please fill out all fields.'
      render :locations_page
    end
  end

  def destroy # Deletes the location when the delete button is pressed
    @location = Location.find(params[:id])
    if @location.destroy
      redirect_to locations_page_locations_path, notice: 'Location deleted successfully'
    else
      redirect_to locations_page_locations_path, alert: 'Failed to delete location'
    end
  end

  def location_params # For the parameters of the locations
    params.require(:location).permit(:name, :address, :operating_hours, :operating_days)
  end
end
