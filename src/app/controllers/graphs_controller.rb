class GraphsController < ApplicationController
  require 'date'

  def wait_time_graph(location)
    current_date= Date.today
    @location=location
    @wait_times={}
    admin_panel = AdminPanel.first

    @appointments= Appointment.where(location: location, date_of_appts: current_date)
   
  
    @appointments.each do |appointment|
      hour = appointment.time_of_appts.strftime("%H:00") # Format time to extract the hour

      @wait_times[hour] ||= 0
      @wait_times[hour] += admin_panel.service_time
    end
    @labels = @wait_times.keys
    @data = @wait_times.values 
     
    respond_to do |format|
      format.html #This will render a format for later-Sourced from ROJ
      format.json { render json: @wait_times } # Optionally, respond with JSON if needed
    end
  end

    
     
  
  def current_date
    @cur_date=Date.today
  end

  def nassau
   wait_time_graph('Princeton')
   
  end
  def hudson
    wait_time_graph('Trenton')
  end
  def mobile
    wait_time_graph('Mobile')
  end
end